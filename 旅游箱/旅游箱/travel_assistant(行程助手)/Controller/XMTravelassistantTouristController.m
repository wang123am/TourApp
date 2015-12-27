//
//  XMTravelassistantTouristController.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/8.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantTouristController.h"
#import "XMTravelassistantDb.h"
#import "XMTravelassistantSetView.h"
#import "XMTravelassistantNewTourist.h"
#import "XMTravelassistantTouristCell.h"
#import "UIView+XM.h"
#import "XMTravelassistantTouristButtomView.h"

#define viewHeight self.view.frame.size.height
#define viewWidth self.view.frame.size.width

@interface XMTravelassistantTouristController ()<XMTravelassistantSetViewDelegate,UITableViewDataSource,UITableViewDelegate,XMTravelassistantNewTouristDelegate>
/** 新建景点*/
@property (nonatomic,weak) XMTravelassistantSetView *setView;
/** 景点数组*/
@property (nonatomic,strong) NSMutableArray *touristArray;
/** tableView*/
@property (nonatomic,weak) UITableView *centerView;
/** 数据库*/
@property (nonatomic,strong) XMTravelassistantDb *db;
@end

@implementation XMTravelassistantTouristController
-(NSMutableArray *)touristArray {
    if (!_touristArray) {
        self.touristArray = [NSMutableArray array];
    }
    return _touristArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"景点规划";
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    //判断当前数据库是否有记录
    [self showTouristView];
    //显示tableView
    [self showTableView];
    //判断当前数据库是否有记录
    XMTravelassistantDb *db = [[XMTravelassistantDb alloc] init];
    self.db = db;
    [db createTouristTable];
    self.touristArray = [db selectTouristAllDataWithCityType:self.cityType];
    if (self.touristArray.count) {
        self.setView.hidden = true;
        self.centerView.hidden = false;
    } else {
        self.setView.hidden = false;
        self.centerView.hidden = true;
    }
}


-(void)showTouristView
{
    XMTravelassistantSetView *setView = [XMTravelassistantSetView setViewWithCenterImg:[UIImage imageNamed:@"viewpoint_nodata"] buttonNomalImg:[UIImage imageNamed:@"viewpoint_page_add_viewpoint_normal"] buttonHigImg:[UIImage imageNamed:@"viewpoint_page_add_viewpoint_press"]];
    setView.frame = self.view.frame;
    setView.delegate = self;
    self.setView = setView;
    [self.view addSubview:setView];
}


-(void)showTableView
{
    //添加底部按钮
    CGFloat buttomViewH = 50;
    XMTravelassistantTouristButtomView *buttomView = [[XMTravelassistantTouristButtomView alloc] initWithFrame:CGRectMake(0, viewHeight - buttomViewH, viewWidth, buttomViewH)];
    [buttomView OnViewClickListener:self action:@selector(travelassistantSetViewButtonClick)];
    [self.view addSubview:buttomView];
    
    //添加tableView
    UITableView *centerView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, viewWidth, viewHeight-buttomViewH-64)];
    centerView.allowsSelection = NO;
    centerView.rowHeight = 75;
    centerView.delegate = self;
    centerView.dataSource = self;
    centerView.backgroundColor = [UIColor clearColor];
    centerView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.centerView = centerView;
    [self.view addSubview:centerView];
    
}

#pragma mark - 点击添加景点
-(void)travelassistantSetViewButtonClick
{
    XMTravelassistantNewTourist *newTouristController = [[XMTravelassistantNewTourist alloc] init];
    newTouristController.delegate = self;
    newTouristController.date = self.date;
    newTouristController.cityType = self.cityType;
    [self.navigationController pushViewController:newTouristController animated:YES];
}

#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.touristArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMTravelassistantTouristCell *cell = [XMTravelassistantTouristCell cellWithTableView:tableView];
    cell.model = self.touristArray[indexPath.row];
//    cell.row = indexPath.row + 1;
    return cell;
}

/**
 *  设置tableView可编辑
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
/**
 *  定义编辑样式
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
}
// 进入编辑模式，按下出现的编辑按钮后

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除数据库内容
    XMTravelassistantTouristModel *model = self.touristArray[indexPath.row];

    [self.db deleteTouristDataWithTouristModel:model];
    
    //删除tableView内容
    [self.touristArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.centerView reloadData];
    if (!self.touristArray.count) {
        self.centerView.hidden = true;
        self.setView.hidden = false;
    } else {
        self.centerView.hidden = false;
        self.setView.hidden = true;
    }
}

/**
 *  修改编辑按钮的文字
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - newtourist delegate
-(void)travelassistantNewTouristCallBack
{
    XMTravelassistantDb *db = [[XMTravelassistantDb alloc] init];
    self.touristArray = [db selectTouristAllDataWithCityType:self.cityType];
    [self.centerView reloadData];
    if (!self.touristArray.count) {
        self.centerView.hidden = true;
        self.setView.hidden = false;
    } else {
        self.centerView.hidden = false;
        self.setView.hidden = true;
    }
}
@end

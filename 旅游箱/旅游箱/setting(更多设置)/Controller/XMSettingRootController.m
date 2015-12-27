//
//  XMSettingRootController.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSettingRootController.h"
#import "XMSettingModel.h"
#import "XMSettingListModel.h"
#import "XMSettingTableViewCell.h"
#import "XMSettingHeaderView.h"
#import "shareViewController.h"

#define viewWidth self.view.frame.size.width
#define viewHeight self.view.frame.size.height

@interface XMSettingRootController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView *centerView;
@property (nonatomic,strong) NSMutableArray *settingArray;
@end

@implementation XMSettingRootController
-(NSMutableArray *)settingArray
{
    if (!_settingArray) {
        _settingArray = [NSMutableArray array];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"setting" ofType:@"plist"]];
        for (int i = 0 ; i < array.count ; i++) {
            NSDictionary *dict = array[i];
            XMSettingModel *settingModel = [XMSettingModel modelWithDict:dict];
            [_settingArray addObject:settingModel];
        }
    }
    return _settingArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更多设置";
    
    //添加tableView
    [self addCenterView];
}

-(void)addCenterView
{
    UITableView *centerView = [[UITableView alloc] init];
    centerView.backgroundColor = [UIColor clearColor];
    centerView.showsHorizontalScrollIndicator = NO;
//    centerView.allowsSelection = NO;
    centerView.sectionHeaderHeight = 50;
    centerView.rowHeight = 50;
    centerView.separatorStyle = UITableViewCellSeparatorStyleNone;
    centerView.frame = self.view.frame;
    centerView.delegate = self;
    centerView.dataSource = self;
    self.centerView = centerView;
    [self.view addSubview:centerView];
}

#pragma mark - tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.settingArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XMSettingModel *model = self.settingArray[section];
    return model.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    XMSettingTableViewCell *cell = [XMSettingTableViewCell cellWithTableView:tableView];
    //传递模型
    XMSettingModel *model = self.settingArray[indexPath.section];
    cell.model = model.list[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    XMSettingModel *model = self.settingArray[section];
    XMSettingHeaderView *headerView = [XMSettingHeaderView headerViewWithTitle:model.title];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 3:{
            // 分享
            shareViewController *shareView = [[shareViewController alloc] init];
            [self addChildViewController:shareView];
            [self.view addSubview:shareView.view];
        }
            
        default:
            break;
    }
}
@end

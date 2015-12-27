//
//  XMTravelassistantNoteController.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/6.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantNoteController.h"
#import "XMTravelassistantDb.h"
#import "XMTravelassistantSetView.h"
#import "XMNewAccountComments.h"
#import "XMTravelassistantNoteModel.h"
#import "XMTravelassistantNoteCell.h"
#import "XMTimer.h"
#import "UIBarButtonItem+XM.h"
#import "UIImage+XM.h"

#define viewHeight self.view.frame.size.height
#define viewWidth self.view.frame.size.width

@interface XMTravelassistantNoteController ()<UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate,XMTravelassistantSetViewDelegate,XMNewAccountCommentsDelegate>
/** 新建笔记*/
@property (nonatomic,weak) XMTravelassistantSetView *setView;
/** tableView*/
@property (nonatomic,weak) UITableView *tableView;
/** 数据库*/
@property (nonatomic,strong) XMTravelassistantDb *db;
/** 笔记数组*/
@property (nonatomic,strong) NSMutableArray *noteArray;
@end

@implementation XMTravelassistantNoteController
-(NSMutableArray *)noteArray {
    if (!_noteArray) {
        self.noteArray = [NSMutableArray array];
    }
    return _noteArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage scaleToSize:[UIImage imageNamed:@"plus_gray_img"] size:CGSizeMake(25, 25)] selectorImg:[UIImage imageNamed:@"plus_gray_img_press"] target:self action:@selector(travelassistantSetViewButtonClick)];
    self.navigationItem.title = @"笔记提醒";
    
    //判断当前数据库是否有记录
    XMTravelassistantDb *db = [[XMTravelassistantDb alloc] init];
    self.db = db;
    //创建数据表,添加数据到笔记表中
    [self.db createNoteTable];
    self.noteArray = [self.db selectNoteAllDataWithCityType:self.noteType];
    //如果表不存在或者表的数据为空
    [self showNewNoteView];
    //显示tableView
    [self showTableView];
    if (self.noteArray.count != 0) {
        self.setView.hidden = true;
        self.tableView.hidden = false;
    } else {
        self.setView.hidden = false;
        self.tableView.hidden = true;
    }
}

/**
 *  显示新建笔记
 */
-(void)showNewNoteView
{
    XMTravelassistantSetView *setView = [XMTravelassistantSetView setViewWithCenterImg:[UIImage imageNamed:@"notewarn_nodata"] buttonNomalImg:[UIImage imageNamed:@"notewarn_create_btn_normal"] buttonHigImg:[UIImage imageNamed:@"notewarn_create_btn_press"]];
    setView.frame = self.view.frame;
    setView.delegate = self;
    self.setView = setView;
    [self.view addSubview:setView];
}

/**
 *  添加和显示tableView
 */
-(void)showTableView
{
    CGFloat margin = 20;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(margin, 64, viewWidth - 2*margin, viewHeight)];
    self.tableView = tableView;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.rowHeight = 70;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    //添加长按事件
    UILongPressGestureRecognizer *tableViewLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewLongClick:)];
    tableViewLongPress.minimumPressDuration = 1;
    [tableView addGestureRecognizer:tableViewLongPress];
}

/**
 *  点击新建笔记时调用
 */
-(void)travelassistantSetViewButtonClick
{
    XMNewAccountComments *commentsController = [[XMNewAccountComments alloc] init];
    commentsController.delegate = self;
    commentsController.controllerTitle = @"新增笔记";
    [self.navigationController pushViewController:commentsController animated:YES];
}
/**
 *  tableView长按事件
 */
-(void)tableViewLongClick:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];//获取响应的长按的indexpath
    if (indexPath == nil)
        NSLog(@"没有点到");
    else
        if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
            //显示dialog
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定要删除该条笔记?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除",nil];
            alertView.tag = indexPath.row;
            [alertView show];
        }
    
}

#pragma mark - 对话框代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //点击删除操作
    if (buttonIndex) {
        //删除数据库
        XMTravelassistantNoteModel *model = self.noteArray[alertView.tag];
        [self.db deleteNoteDataWithNoteModel:model];
        [self.noteArray removeObjectAtIndex:alertView.tag];
        if (self.noteArray.count == 0) {
            self.tableView.hidden = true;
            self.setView.hidden = false;
        }
        [self.tableView reloadData];
        
        int noteCount = [[self.db selectTravelassistantDataWithCityType:self.noteType colmnName:@"noteCount"] intValue];
        noteCount--;
        [self.db upDateTravelassistantWithColmnName:@"noteCount" colmnValue:[NSString stringWithFormat:@"%d",noteCount] cityType:self.noteType];
    }
}

#pragma mark - tableView方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.noteArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    XMTravelassistantNoteCell *cell = [XMTravelassistantNoteCell cellWithTableView:tableView];
    //传递模型
    cell.model = self.noteArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMTravelassistantNoteModel *model = self.noteArray[indexPath.row];
    XMNewAccountComments *commentsController = [[XMNewAccountComments alloc] init];
    commentsController.text = model.noteText;
    commentsController.delegate = self;
    commentsController.controllerTitle = @"笔记详情";
    [self.navigationController pushViewController:commentsController animated:YES];
}

#pragma mark - 代理回调方法
-(void)commentsCallBackWithText:(NSString *)text
{
    XMTravelassistantNoteModel *model = [[XMTravelassistantNoteModel alloc]init];
    model.noteText= text;
    model.cityType = self.noteType;
    model.noteTime = [XMTimer currentTime:@"yyyy/MM/dd HH:mm"];
    
    [self.db insertNoteWithModel:model];
    //添加数据到数组
    self.setView.hidden = true;
    self.tableView.hidden = false;
    [self.noteArray addObject:model];
    [self.tableView reloadData];
    //更改行程助手表数据
    int noteCount = [[self.db selectTravelassistantDataWithCityType:self.noteType colmnName:@"noteCount"] intValue];
    noteCount ++;
    [self.db upDateTravelassistantWithColmnName:@"noteCount" colmnValue:[NSString stringWithFormat:@"%d",noteCount] cityType:self.noteType];
}
@end

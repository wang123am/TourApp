//
//  XMAccountRoot.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/17.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMAccountRootController.h"
#import "XMAccountHeaderView.h"
#import "XMNewAccount.h"
#import "XMAccountDb.h"
#import "XMAccountTableViewCell.h"
#import "XMAccountModel.h"
#import "UIView+XM.h"
#import "XMCalendar.h"
#import "XMTimer.h"
#import "UIBarButtonItem+XM.h"
#import "UIImage+XM.h"
#import "XMMonthConsult.h"
#import "XMAccountTool.h"

#define viewHeight self.view.frame.size.height
#define viewWidth self.view.frame.size.width

#define headerHeight 60
@interface XMAccountRootController ()<UITableViewDataSource,UITableViewDelegate,XMNewAccountDelegate,XMCalendarDelegate>
/** 头部日期view*/
@property (nonatomic,weak) XMAccountHeaderView *headerView;
/** 中间列表*/
@property (nonatomic,weak) UITableView *tableView;
/** 保存数据库数据的数组*/
@property (nonatomic,strong) NSMutableArray *accountArray;
/** 数据库*/
@property (nonatomic,strong) XMAccountDb *db;
/** */
@property (nonatomic,weak) UIImageView *centerView;
/** */
@property (nonatomic,weak) UIButton *addAccountButton;
@end

@implementation XMAccountRootController

-(NSMutableArray *)accountArray
{
    if (!self.showDate) self.showDate = [XMTimer toDay];
    if (!_accountArray) _accountArray = [self.db selectAccountData:self.showDate];
    return _accountArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_leftBarButtonItemType)
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.title = @"记账本";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage scaleToSize:[UIImage imageNamed:@"account_page_title_account_action"] size:CGSizeMake(50, 50)] selectorImg:nil target:self action:@selector(rightBarButtonClick)];
    //1.添加头部view
    [self addHeaderView];
    //判断当天是否有记账记录
    XMAccountDb *db = [[XMAccountDb alloc] init];
    self.db = db;
    
    if (!self.showDate) self.showDate = [XMTimer toDay];
    NSLog(@"%@",self.showDate);
    if ([db isConsumefromToday:self.showDate]) {
        [self showTableView];
        NSLog(@"有记账");
    } else {
        [self addCenterView];
        NSLog(@"无记账");
    }
    //3.添加新增记账按钮
    [self addNewAccount];
    
    //计算今天总消费
    self.headerView.moneyLabel.text = [NSString stringWithFormat:@"¥ %@",[XMAccountTool calculateAllConsumeWithModelArray:self.accountArray db:self.db]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}
/**
 *  添加头部view
 */
-(void)addHeaderView
{
    XMAccountHeaderView *headerView  = [[XMAccountHeaderView alloc] initWithFrame:CGRectMake(0, 70, viewWidth, headerHeight)];
    [headerView OnViewClickListener:self action:@selector(headerViewClick)];
    if (self.showDate) headerView.date = self.showDate;
    self.headerView = headerView;
    [self.view addSubview:headerView];
    
}
/**
 *  添加新增记账按钮
 */
-(void)addNewAccount
{
    CGFloat newAccountSize = 50;
    CGFloat margin = 20;
    UIButton *newAccount = [[UIButton alloc] initWithFrame:CGRectMake(margin, viewHeight-newAccountSize-margin, newAccountSize, newAccountSize)];
    self.addAccountButton = newAccount;
    [newAccount setImage:[UIImage imageNamed:@"account_page_add_normal"] forState:UIControlStateNormal];
    [newAccount setImage:[UIImage imageNamed:@"account_page_add_press"] forState:UIControlStateHighlighted];
    [newAccount addTarget:self action:@selector(newAccountButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newAccount];
}

/**
 *  数据库有数据时调用
 */
-(void)showTableView
{
    CGFloat margin = 20;
    CGFloat centerViewY = CGRectGetMaxY(self.headerView.frame);
    UITableView *centerView = [[UITableView alloc] initWithFrame:CGRectMake(margin, centerViewY, viewWidth - 2*margin, viewHeight - centerViewY)];
    centerView.allowsSelection = NO;
    centerView.showsVerticalScrollIndicator = NO;
    centerView.backgroundColor = [UIColor clearColor];
    centerView.separatorStyle = UITableViewCellSeparatorStyleNone;
    centerView.rowHeight = 60;
    centerView.sectionFooterHeight = 8;
    centerView.delegate = self;
    centerView.dataSource = self;
    self.tableView = centerView;
    [self.view addSubview:centerView];
}

//数据库没有记录时调用
-(void)addCenterView
{
    UIImageView *centerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account_page_set_city_toast"]];
    CGFloat margin = 20;
    self.centerView = centerView;
    centerView.frame = CGRectMake(margin, CGRectGetMaxY(self.headerView.frame), viewWidth-2*margin, 45);
    [self.view addSubview:centerView];
}


/**
 *  点击新增记账
 */
-(void)newAccountButtonClick
{
    XMNewAccount *newAccount = [[XMNewAccount alloc] init];
    newAccount.delegate = self;
    [self.navigationController pushViewController:newAccount animated:YES];
}

/**
 *  点击日期
 */
-(void)headerViewClick
{
    XMCalendar *calendar = [[XMCalendar alloc] init] ;
    calendar.delegate = self;
    [self.navigationController pushViewController:calendar animated:YES];
}

/**
 *  点击右边统计金额按钮
 */
-(void)rightBarButtonClick
{
    XMMonthConsult *monConsult = [[XMMonthConsult alloc] init];
    [self.navigationController pushViewController:monConsult animated:YES];
}

#pragma mark-tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accountArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    XMAccountTableViewCell *cell = [XMAccountTableViewCell cellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    //传递模型
    cell.tableViewModel = self.accountArray[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *footView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_griditem_bottom_border"]];
    return footView;
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
    XMAccountModel *model = self.accountArray[indexPath.row];
    [self.db deleteAccountWithid:model.modelid];
    
    //删除tableView内容
    [self.accountArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView reloadData];
    if (!self.accountArray.count) {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        [self addCenterView];
    }
}

/**
 *  修改编辑按钮的文字
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


/**
 *  点击保存按钮回调
 */
-(void)saveButtonClick
{
    [self showCenterViewWith:[XMTimer toDay]];
    self.headerView.dayLabel.text = [XMTimer currentTime:@"MM/dd"];
    self.headerView.weekLabel.text = [XMTimer weekdayString:[XMTimer toDay]];
}

-(void)seletorDateCallBack:(NSString *)date viewTag:(int)tag
{
    NSString *dateStr = [date substringWithRange:NSMakeRange(5, 5)];
    NSString *week = [XMTimer weekdayString:date];
    
    self.headerView.dayLabel.text = dateStr;
    self.headerView.weekLabel.text = week;
    
    [self showCenterViewWith:date];
}

/**
 *  根据日期来判断中间显示哪个view
 */
-(void)showCenterViewWith:(NSString *)date
{
    //判断当前是否有消费记录
    if ([self.db isConsumefromToday:date]) {
        if (self.tableView != nil) {
            _accountArray = nil;
        } else {
            [self.centerView removeFromSuperview];
            [self.addAccountButton removeFromSuperview];
            [self showTableView];
            [self addNewAccount];
        }
        _accountArray = [self.db selectAccountData:date];
        //计算当天总消费
        self.headerView.moneyLabel.text = [NSString stringWithFormat:@"¥ %@",[XMAccountTool calculateAllConsumeWithModelArray:self.accountArray db:self.db]];
        [self.tableView reloadData];
    } else {
        self.headerView.moneyLabel.text = @"¥ 0";
        self.accountArray = nil;
        if (self.centerView == nil) {
            [self.tableView removeFromSuperview];
            [self addCenterView];
        } else {
            
        }
    }
}

@end

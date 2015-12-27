//
//  XMMonthConsult.m
//  旅游箱
//
//  Created by 梁亦明 on 15/3/31.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMMonthConsult.h"
#import "XMMonthConsultHeader.h"
#import "XMTimer.h"
#import "XMAccountDb.h"
#import "XMAccountModel.h"
#import "XMAccountTableViewCell.h"
#import "XMMonthConsultHeaderView.h"
#import "XMMonthConsultFooterView.h"
#import "XMAccountTool.h"

#define viewHeight self.view.frame.size.height
#define viewWidth self.view.frame.size.width
@interface XMMonthConsult ()<UITableViewDataSource,UITableViewDelegate>
/** 头部布局*/
@property (nonatomic,weak) XMMonthConsultHeader *headerView;
/** 中间tableView*/
@property (nonatomic,weak) UITableView *centerView;
/** 某月的消费记录*/
@property (nonatomic,strong) NSMutableArray *monthArray;
/** 数据库*/
@property (nonatomic,strong) XMAccountDb *db;
@end

@implementation XMMonthConsult
-(NSMutableArray *)monthArray
{
    if (!_monthArray) _monthArray = [self.db selectAccountDataFromMonth:[NSString stringWithFormat:@"%@%@",[XMTimer currentTime:@"yyyy/MM"],@"%"]];
    return _monthArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消费合计";
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    XMAccountDb *db = [[XMAccountDb alloc] init];
    self.db = db;
    //1.添加头部界面
    [self addHeaderView];
    
    //2.添加tableView
    [self addCenterView];
    
}

-(void)addHeaderView
{
    XMMonthConsultHeader *headerView = [[XMMonthConsultHeader alloc] initWithFrame:CGRectMake(0, 70, viewWidth, 70)];
    self.headerView = headerView;
    [self.view addSubview:headerView];
    
    //计算右边总金额
    float allMoney = 0;
    for (NSArray *array in self.monthArray) {
        NSString *moneyStr = [XMAccountTool calculateAllConsumeWithModelArray:array db:self.db];
        float money = [moneyStr floatValue];
        allMoney += money;
    }
    //截取小数点后两位
    NSString *moneyStr = [NSString stringWithFormat:@"¥ %f",allMoney];
    NSRange resultRange = [moneyStr rangeOfString:@"."];
    headerView.rightLabel.text = [moneyStr substringToIndex:resultRange.location + 3];
}

-(void)addCenterView
{
    if (!self.monthArray.count) return;
    UITableView *centerView = [[UITableView alloc] init];
    CGFloat margin = 20;
    CGFloat centerViewY = margin*0.5 + CGRectGetMaxY(self.headerView.frame);
    centerView.frame = CGRectMake(margin, centerViewY, viewWidth-2*margin, viewHeight-centerViewY);
    centerView.dataSource = self;
    centerView.delegate = self;
    centerView.rowHeight = 60;
    centerView.sectionHeaderHeight = 45;
    centerView.sectionFooterHeight = 45;
    centerView.separatorStyle = UITableViewCellSeparatorStyleNone;
    centerView.allowsSelection = NO;
    centerView.backgroundColor = [UIColor clearColor];
    centerView.showsVerticalScrollIndicator = NO;
    self.centerView = centerView;
    [self.view addSubview:centerView];
}
#pragma mark - tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.monthArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.monthArray[section];
    return array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMAccountTableViewCell *cell = [XMAccountTableViewCell cellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    NSArray *array = self.monthArray[indexPath.section];
    XMAccountModel *model = array[indexPath.row];
    cell.tableViewModel = model;
    return  cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = self.monthArray[section];
    XMAccountModel *model = array[0];
    XMMonthConsultHeaderView *headerView = [XMMonthConsultHeaderView headerViewWithDate:model.date week:[XMTimer weekdayString:model.date]];
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSArray *array = self.monthArray[section];
    XMMonthConsultFooterView *footerView = [XMMonthConsultFooterView footerViewWithMoney:[XMAccountTool calculateAllConsumeWithModelArray:array db:self.db]];
    return footerView;
}

@end

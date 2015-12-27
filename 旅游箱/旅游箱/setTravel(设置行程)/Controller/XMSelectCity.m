//
//  XMSelectCity.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/5.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSelectCity.h"
#import "XMSearchBar.h"
#import "XMCityGround.h"
#import "UIImage+XM.h"
#import "XMSetTravelDB.h"
#import "XMTarBarButton.h"
#import "XMOutSizeCityCell.h"
#import "XMChinaCityScroller.h"
#import "XMLetterCity.h"

#define viewMargin 10
#define viewWidth self.view.frame.size.width
#define scrollerY CGRectGetMaxY(self.tabBarView.frame)
#define scrollerH self.view.frame.size.height - scrollerY
#define titleViewHeight 30
#define navigationBg [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]

@interface XMSelectCity () <UITableViewDelegate,UITableViewDataSource,XMTarBarButtonDelegate,XMChinaCityScrollerDelegate,XMLetterCityDelegate>
@property (nonatomic,weak) XMSearchBar *searchBar;
@property (nonatomic,weak) XMTarBarButton *tabBarView;
@property (nonatomic,weak) UIScrollView *scrollerContent;
@property (nonatomic,weak) UITableView *tableViewContent;
/** 记录当前选中的是境内还是境外*/
@property (nonatomic,weak) UILabel *selectLabel;
/** 记录当前tableView指向的cell*/
@property (nonatomic,weak) UITableViewCell *cell;
/** 记录境外城市的信息*/
@property (nonatomic,strong)NSMutableArray *outSideCityArray;
/** 拿到数据库对象*/
@property (nonatomic,strong) XMSetTravelDB *setTravelDB;
@end

@implementation XMSelectCity

-(NSMutableArray *)outSideCityArray
{
    if (_outSideCityArray == nil) {
        self.outSideCityArray = [NSMutableArray array];
        //查询境外城市的信息
        _outSideCityArray = [self.setTravelDB selectOutSideCityData];
    }
    return _outSideCityArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.setTravelDB = [[XMSetTravelDB alloc] init];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    //1.进行初始化工作
    self.navigationItem.title = @"选择出发城市";
    self.view.backgroundColor = navigationBg;
    //2.添加搜索框
    [self addSearchBar];
    //3.添加境内境外按钮
    [self addTabBarButton];
    //4.添加scrollerView 显示国内城市
    [self addScrollContent];
    //5.添加tableView 显示国外城市
    [self addTableViewContent];
    self.tableViewContent.frame = self.scrollerContent.frame;
}

#pragma mark --添加子控件
/**
 *  添加搜索框
 */
-(void)addSearchBar
{
    XMSearchBar *searchBar = [XMSearchBar searchBar];
    self.searchBar = searchBar;
    searchBar.frame = CGRectMake(viewMargin, 80, viewWidth - 2 * viewMargin, 40);
    [self.view addSubview:searchBar];
}

/**
 *  添加境内境外按钮
 */
-(void)addTabBarButton
{
    XMTarBarButton *tarBarButton = [XMTarBarButton barButton];
    self.tabBarView = tarBarButton;
    tarBarButton.delegate = self;
    tarBarButton.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame) + viewMargin, viewWidth, 40);
    [self.view addSubview:tarBarButton];
    
    //默认选中境内
    [self tarBarButtonClick:tarBarButton.leftLabel guideView:tarBarButton.guideView];
}

/**
 *  添加scroller 滚动条
 */
#pragma mark -添加scroll滚动条
-(void)addScrollContent
{
    XMChinaCityScroller *scrollerContent = [XMChinaCityScroller scrollerWithCityArray:[self.setTravelDB selectChinaHotCity]];
    scrollerContent.frame = CGRectMake(0, scrollerY, viewWidth, scrollerH);
    scrollerContent.delegate = self;
    self.scrollerContent = scrollerContent;
    [self.view addSubview:scrollerContent];
}

/**
 *  添加境外城市
 */
-(void)addTableViewContent
{
    UITableView *tableViewContent = [[UITableView alloc] init];
    self.tableViewContent = tableViewContent;
    tableViewContent.hidden = YES;
    tableViewContent.delegate = self;
    tableViewContent.dataSource = self;
    [self.view addSubview:tableViewContent];
}
#pragma mark -代理方法
-(void)tarBarButtonClick:(UILabel *)tarBarButton guideView:(UIImageView *)guideView
{
    if (tarBarButton.tag) {
        self.tableViewContent.hidden = YES;
        self.scrollerContent.hidden = NO;
        //改变颜色
        self.selectLabel.textColor = [UIColor blackColor];
        self.selectLabel = tarBarButton;
        tarBarButton.textColor = [UIColor redColor];
        [guideView setImage:[UIImage imageNamed:@"citychoice_page_native_choice"]];
    } else {
        self.tableViewContent.hidden = NO;
        self.scrollerContent.hidden = YES;
        //改变颜色
        self.selectLabel.textColor = [UIColor blackColor];
        self.selectLabel = tarBarButton;
        tarBarButton.textColor = [UIColor redColor];
        [guideView setImage:[UIImage imageNamed:@"citychoice_page_inter_choice"]];
    }
}

/**
 *  选择字母的城市代理的回调函数
 */
-(void)letterCityCallBackWithCityName:(NSString *)cityName
{
    //回传参数
    if ([self.delegate respondsToSelector:@selector(selectCityCallBackWithCity:controllerTag:)]) {
        [self.delegate selectCityCallBackWithCity:cityName controllerTag:self.tag];
    }
}
-(void)lastButtonHeight:(CGFloat)lastButtonHeight
{
    self.scrollerContent.contentSize = CGSizeMake(0,lastButtonHeight);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.outSideCityArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    XMCityGround *ground = self.outSideCityArray[section];
    return ground.leaves.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    XMOutSizeCityCell *cell = [XMOutSizeCityCell cellWithTableView:tableView];
    
    //获取模型设置数据
    XMCityGround *ground = self.outSideCityArray[indexPath.section];
    XMLeaves *leaves = ground.leaves[indexPath.row];
    cell.leaves = leaves;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    XMCityGround *ground = self.outSideCityArray[section];
    
    return ground.name;
}
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [NSMutableArray array];
    for (XMCityGround *ground in self.outSideCityArray){
        [array addObject:ground.name];
    }
    return array;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    return index;
}

#pragma mark -控件点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell.accessoryType = UITableViewCellAccessoryNone;
    // 获取点击行的cell
    UITableViewCell *cell   = [tableView cellForRowAtIndexPath:indexPath];
    self.cell = cell;
    // 标记cell
    cell.accessoryType  = UITableViewCellAccessoryCheckmark;
    // 更改模型数据
    XMCityGround *ground = self.outSideCityArray[indexPath.section];
    XMLeaves *leaves = ground.leaves[indexPath.row];
    leaves.select = true;
    // 取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //回传参数
    if ([self.delegate respondsToSelector:@selector(selectCityCallBackWithCity:controllerTag:)]) {
        [self.delegate selectCityCallBackWithCity:leaves.cityName controllerTag:self.tag];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)listButtonClick:(NSString *)buttonText
{
    //城市
    if (buttonText.length > 1) {
        //回传参数
        if ([self.delegate respondsToSelector:@selector(selectCityCallBackWithCity:controllerTag:)]) {
            [self.delegate selectCityCallBackWithCity:buttonText controllerTag:self.tag];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        //字母
        XMLetterCity *letterCity = [[XMLetterCity alloc] init];
        letterCity.delegate = self;
        letterCity.navTitle = buttonText;
        [self.navigationController pushViewController:letterCity animated:YES];
    }
}

@end

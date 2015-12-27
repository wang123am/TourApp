//
//  XMTravelassistantNewTourist.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/10.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantNewTourist.h"
#import "XMTravelassistantTouristItem.h"
#import "XMTravelassistantTouristPlaceItem.h"
#import "XMTravelassistantTouristTicketItem.h"
#import "UIView+XM.h"
#import "UILabel+XM.h"
#import "XMTravelassistantMapController.h"
#import "XMExrateKeyboard.h"
#import "XMCurrencySelector.h"
#import "XMSetTravelTool.h"
#import "XMAccountDb.h"
#import "UIBarButtonItem+XM.h"
#import "XMTravelassistantDb.h"
#import "XMTravelassistantTouristModel.h"

#define viewWidth self.view.frame.size.width
#define viewHeight self.view.frame.size.height
#define keyboardH 200

@interface XMTravelassistantNewTourist ()<XMTravelassistantMapDelegate,XMExrateKeyboardDelegate,XMCurrencySelectorDelegate>
/** 景点名称*/
@property (nonatomic,weak) XMTravelassistantTouristItem *nameView;
/** 地理位置*/
@property (nonatomic,weak) XMTravelassistantTouristItem *pointView;
/** 自动获取位置*/
@property (nonatomic,weak) XMTravelassistantTouristPlaceItem *placeItem;
/** 添加到记账本*/
@property (nonatomic,weak) UILabel *addAccountLabel;
/** 金额*/
@property (nonatomic,weak) XMTravelassistantTouristTicketItem *moneyItem;
/** 币种选择*/
@property (nonatomic,weak) XMTravelassistantTouristTicketItem *exrateItem;
/** 自定义键盘*/
@property (nonatomic,weak) XMExrateKeyboard *keyboard;
/** 取消按钮*/
@property (nonatomic,weak) UIButton *keyButton;
/** 保存输入金额*/
@property (nonatomic,copy) NSString * money;
/** 保存金额到记账本数据库*/
@property (nonatomic,strong) XMAccountDb *accountDb;
/** 保存景点规划到数据库*/
@property (nonatomic,strong) XMTravelassistantDb *travelassistantDb;
@end

@implementation XMTravelassistantNewTourist
-(XMAccountDb *)accountDb
{
    if (!_accountDb) _accountDb = [[XMAccountDb alloc] init];
    return _accountDb;
}

-(XMTravelassistantDb *)travelassistantDb
{
    if (!_travelassistantDb) _travelassistantDb = [[XMTravelassistantDb alloc] init];
    return _travelassistantDb;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.navigationItem.title = @"添加景点";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"account_page_title_right_finish"] selectorImg:[UIImage imageNamed:@"account_page_title_right_finish_press"] target:self action:@selector(rightBarButtonItemClick)];
    
    CGFloat margin = 20;
    CGFloat itemHeight = 40;
    CGFloat itemWidth = viewWidth - 2*margin;
    
    //景点名称
    XMTravelassistantTouristItem *nameView = [XMTravelassistantTouristItem touristItemWithTitle:@"景点名称"];
    nameView.frame = CGRectMake(margin, margin + 64, itemWidth, itemHeight);
    self.nameView = nameView;
    [self.view addSubview:nameView];
    //地理位置
    XMTravelassistantTouristItem *pointView = [XMTravelassistantTouristItem touristItemWithTitle:@"地理位置"];
    pointView.textField.font = [UIFont systemFontOfSize:10];
    pointView.frame = CGRectMake(margin, CGRectGetMaxY(nameView.frame) + 1, itemWidth, itemHeight);
    self.pointView = pointView;
    [self.view addSubview:pointView];
    //添加自动获取
    XMTravelassistantTouristPlaceItem *placeItem = [[XMTravelassistantTouristPlaceItem alloc] initWithFrame:CGRectMake(295, CGRectGetMaxY(pointView.frame) + 5, 60, 20)];
    [placeItem OnViewClickListener:self action:@selector(placeItemClick)];
    self.placeItem = placeItem;
    [self.view addSubview:placeItem];
    
    //添加景点门票
    CGFloat ticketLabelY = CGRectGetMaxY(placeItem.frame) + 10;
    CGFloat ticketLabelX = 80;
    UILabel * ticketLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, ticketLabelY, ticketLabelX, itemHeight)];
    ticketLabel.text = @"景点门票";
    ticketLabel.textColor = [UIColor grayColor];
    ticketLabel.font = [UIFont systemFontOfSize:13];
    ticketLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:ticketLabel];
    
    //添加添加到记账本
    UILabel *addAccountLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth - margin - ticketLabelX, ticketLabelY, ticketLabelX, itemHeight)];
    [addAccountLabel OnViewClickListener:self action:@selector(addAccountClick)];
    addAccountLabel.text = @"添加到记账本";
    addAccountLabel.textColor = [UIColor redColor];
    addAccountLabel.alpha = 0.7;
    addAccountLabel.font = [UIFont systemFontOfSize:13];
    addAccountLabel.textAlignment = NSTextAlignmentCenter;
    self.addAccountLabel = addAccountLabel;
    [self.view addSubview:addAccountLabel];
    
    //添加价格条目
    XMTravelassistantTouristTicketItem *moneyItem = [XMTravelassistantTouristTicketItem ticketItemWithTitle:@"价格" rightLabelText:@"0"];
    [moneyItem OnViewClickListener:self action:@selector(moneyItemClick)];
    moneyItem.frame = CGRectMake(margin, CGRectGetMaxY(addAccountLabel.frame), itemWidth, itemHeight);
    self.moneyItem = moneyItem;
    [self.view addSubview:moneyItem];
    
    //添加币种选择
    XMTravelassistantTouristTicketItem *exrateItem = [XMTravelassistantTouristTicketItem ticketItemWithTitle:@"币种" rightLabelText:@"CNY"];
    [exrateItem OnViewClickListener:self action:@selector(exrateItemClick)];
    exrateItem.frame = CGRectMake(margin, CGRectGetMaxY(moneyItem.frame) + 1, itemWidth, itemHeight);
    exrateItem.itemType = exrateItemType;
    self.exrateItem = exrateItem;
    [self.view addSubview:exrateItem];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.view isExclusiveTouch]) {
        [self closeKeyboard];
    }
}

-(void)closeKeyboard
{
    [self.nameView.textField resignFirstResponder];
    [self.pointView.textField resignFirstResponder];
}
#pragma mark -点击事件处理
/**
 *  点击导航右边按钮
 */
-(void)rightBarButtonItemClick
{
    //获取景点
    NSString *viewStr = [self.nameView.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([viewStr isEqualToString:@""]) {
        [XMSetTravelTool showToast:@"景点名称不能空" view:self.view];
    } else {
        //获取地理位置
        NSString *pointStr = [self.pointView.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //获取门票价格
        NSString *moneyStr = self.moneyItem.rightLabel.text;
        //获取门票币种
        NSString *exrateStr = self.exrateItem.rightLabel.text;
        
        XMTravelassistantTouristModel *model = [[XMTravelassistantTouristModel alloc] init];
        model.tourName = viewStr;
        model.tourLocation = pointStr;
        model.tourMoney = moneyStr;
        model.tourExrate = exrateStr;
        model.cityType = self.cityType;
        
        //创建和保存数据到数据库
       
        [self.travelassistantDb insertTouristWithModel:model];
        
        //更改行程助手的数据
        int touristCount = [[self.travelassistantDb selectTravelassistantDataWithCityType:self.cityType colmnName:@"touristCount"] intValue];
        touristCount++ ;
        [self.travelassistantDb upDateTravelassistantWithColmnName:@"touristCount" colmnValue:[NSString stringWithFormat:@"%d",touristCount] cityType:self.cityType];
        
        if ([self.delegate respondsToSelector:@selector(travelassistantNewTouristCallBack)]) {
            [self.delegate travelassistantNewTouristCallBack];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 *  获取位置
 */
-(void)placeItemClick
{
    [self closeKeyboard];
    XMTravelassistantMapController *mapController = [[XMTravelassistantMapController alloc] init];
    mapController.delegate = self;
    [self.navigationController pushViewController:mapController animated:YES];
}

/**
 *  当用户点击金额时取消其他控件点击
 */
-(void)userInterface:(BOOL)flag
{
    self.nameView.userInteractionEnabled = flag;
    self.pointView.userInteractionEnabled = flag;
    self.placeItem.userInteractionEnabled = flag;
    self.addAccountLabel.userInteractionEnabled = flag;
    self.exrateItem.userInteractionEnabled = flag;
}

/**
 *  点击金额
 */
-(void)moneyItemClick
{

    if (self.keyboard) {
        return;
    }
    
    [self closeKeyboard];
    [self userInterface:NO];
    //添加键盘
    XMExrateKeyboard *keyboard = [[XMExrateKeyboard alloc] initWithFrame:CGRectMake(0, viewHeight-keyboardH, viewWidth, keyboardH)];
    self.keyboard = keyboard;
    UIButton * keyButton = keyboard.otherButtonArray[keyboard.otherButtonArray.count-1];
    self.keyButton = keyButton;
    //设置键盘最后一个键为取消键
    [keyButton setImage:[UIImage imageNamed:@"account_page_calc_cancel_down"] forState:UIControlStateHighlighted];
    [keyButton setImage:[UIImage imageNamed:@"account_page_calc_cancel_up"] forState:UIControlStateNormal];
    keyboard.delegate = self;
    [self.view addSubview:keyboard];
}
/**
 *  添加到记账本
 */
-(void)addAccountClick
{
    [self closeKeyboard];
    if ([self.moneyItem.rightLabel.text intValue]) {
        //币种
        NSString *exrate = self.exrateItem.rightLabel.text;
        //获取符号
        NSString *code = [self.accountDb selectMoneySymbolWithCode:exrate];
        //金额
        NSString *money = self.moneyItem.rightLabel.text;
        [self.accountDb insertToAccountWithType:@"门票" money:money exrate:exrate code:code date:self.date comments:@"" imgPath:@""];
        [XMSetTravelTool showToast:@"添加记账成功" view:self.view];
    } else {
        [XMSetTravelTool showToast:@"价格不能为0" view:self.view];
    }
}
/**
 *  点击币种
 */
-(void)exrateItemClick
{
    [self closeKeyboard];
    XMCurrencySelector *currency = [[XMCurrencySelector alloc] init];
    currency.currentExrate = self.exrateItem.rightLabel.text;
    currency.delegate = self;
    [self.navigationController pushViewController:currency animated:YES];
}

#pragma mark - 代理回调
-(void)travelassistantMapSelectCity:(NSString *)city
{
    self.pointView.textField.text = city;
}
/**
 *  点击键盘按钮时调用
 */
-(void)keyboardButtonClick:(NSString *)buttonText
{
    if(buttonText==nil){
        if (self.money){
            self.moneyItem.rightLabel.text = self.money;
        }
        [self userInterface:YES];
        [self.keyboard removeFromSuperview];
    } else if([buttonText isEqualToString:@"0"]){
        //按下0键
        if (self.money && self.money.length < 9) {
            self.money = [NSString stringWithFormat:@"%@%@",self.money,buttonText];
            self.moneyItem.rightLabel.text = self.money;
        } else if(!self.money){
            self.money = nil;
            self.moneyItem.rightLabel.text = @"0";
        }
    } else if([buttonText isEqualToString:@"C"]){
        //按下取消键
        self.money = nil;
        self.moneyItem.rightLabel.text = @"0";
    } else {
        //按下1-9
        if (self.money && self.money.length < 9) {
            self.money = [NSString stringWithFormat:@"%@%@",self.money,buttonText];
            self.moneyItem.rightLabel.text = self.money;
        }else if(!self.money){
            self.money = buttonText;
            self.moneyItem.rightLabel.text = buttonText;
        }
    }
    
    //根据金额是否为0进行切换图片
    if ([self.moneyItem.rightLabel.text isEqualToString:@"0"]) {
        [self.keyButton setImage:[UIImage imageNamed:@"account_page_calc_cancel_down"] forState:UIControlStateHighlighted];
        [self.keyButton setImage:[UIImage imageNamed:@"account_page_calc_cancel_up"] forState:UIControlStateNormal];
    } else {
        [self.keyButton setImage:[UIImage imageNamed:@"account_page_calc_ok_down"] forState:UIControlStateHighlighted];
        [self.keyButton setImage:[UIImage imageNamed:@"account_page_calc_ok"] forState:UIControlStateNormal];
    }
}

-(void)currencySelectorCallBack:(NSString *)currencyName
{
    self.exrateItem.rightLabel.text = currencyName;
}
@end

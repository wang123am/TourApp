//
//  XMExrateRootController.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/23.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMExrateRootController.h"
#import "XMExrateItem.h"
#import "XMExrateKeyboard.h"
#import "XMCurrencySelector.h"
#import "XMExrateDb.h"
#import "UIBarButtonItem+XM.h"
#import "UIImage+XM.h"

#define keyboardH 200
#define navWidth 64
#define viewHeight self.view.frame.size.height
#define viewWidth self.view.frame.size.width

@interface XMExrateRootController ()<XMExrateKeyboardDelegate,XMExrateItemDelegate,XMCurrencySelectorDelegate>
/** 顶部条目*/
@property (nonatomic,weak) XMExrateItem *topItem;
/** 底部条目*/
@property (nonatomic,weak) XMExrateItem *buttomItem;
@property (nonatomic,copy) NSString *money;
/** 用于记录当前点击的币种选择按钮*/
@property (nonatomic,weak) UIButton *exrateButton;
@property (nonatomic,strong) XMExrateDb *db;
@end

@implementation XMExrateRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    XMExrateDb *db = [[XMExrateDb alloc] init];
    self.db = db;
    self.navigationItem.title = @"汇率换算";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"exrate_page_swap_lang_img"] selectorImg:[UIImage imageNamed:@"exrate_page_swap_lang_img_press"] target:self action:@selector(rightBarButtonItemClick)];
    //添加两条换算条目
    [self addExrateItem];
    //添加中间背景图片
    [self addCenterBackground];
    //添加底部自定义键盘
    [self addExrateKeyboard];
    
}

/**
 *  添加两条换算条目
 */
-(void) addExrateItem
{
    //添加顶部条目
    CGFloat itemW = 330;
    CGFloat itemH = 60;
    CGFloat margin = (self.view.frame.size.width - itemW ) * 0.5;
    XMExrateItem *topItem = [[XMExrateItem alloc] initWithFrame:CGRectMake(margin,navWidth + margin, itemW, itemH)];
    self.topItem = topItem;
    topItem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"exrate_src"]];
    topItem.numberLabel.textColor = [UIColor colorWithRed:100/255.0 green:210/255.0 blue:200/255.0 alpha:1];
    [topItem.exrateButton setTitle:@"CNY" forState:UIControlStateNormal];
    topItem.delegate = self;
    [self.view addSubview:topItem];
    //添加底部条目
    XMExrateItem *buttomItem = [[XMExrateItem alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(topItem.frame) + margin, itemW, itemH)];
    self.buttomItem = buttomItem;
    [buttomItem.exrateButton setTitle:@"USD" forState:UIControlStateNormal];
    buttomItem.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"exrate_des"]];
    buttomItem.delegate= self;
    [self.view addSubview:buttomItem];
}

-(void)addCenterBackground
{
    CGFloat imageH = 170;
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage scaleToSize:[UIImage imageNamed:@"exrate_page_bg_cion"] size:CGSizeMake(viewWidth, imageH)]];
    image.frame = CGRectMake(0, viewHeight-keyboardH-imageH + 27, viewWidth, imageH);
    [self.view addSubview:image];
}
/**
 *  添加底部自定义键盘
 */
-(void)addExrateKeyboard
{
    XMExrateKeyboard *keyboard = [[XMExrateKeyboard alloc] initWithFrame:CGRectMake(0, viewHeight-keyboardH, viewWidth, keyboardH)];
    keyboard.delegate = self;
    [self.view addSubview:keyboard];
}

/**
 *  点击键盘按钮时调用
 */
-(void)keyboardButtonClick:(NSString *)buttonText
{

    if(buttonText==nil){
        //按下的时勾键
        [self calculateResult];
    } else if([buttonText isEqualToString:@"0"]){
        //按下0键
        if (self.money && self.money.length < 9) {
            self.money = [NSString stringWithFormat:@"%@%@",self.money,buttonText];
            self.topItem.numberLabel.text = self.money;
        } else if(!self.money){
            self.money = nil;
            self.topItem.numberLabel.text = @"0";
        }
    } else if([buttonText isEqualToString:@"C"]){
        //按下取消键
        self.money = nil;
        self.topItem.numberLabel.text = @"0";
        self.buttomItem.numberLabel.text = @"0";
    } else {
        //按下1-9
        if (self.money && self.money.length < 9) {
            self.money = [NSString stringWithFormat:@"%@%@",self.money,buttonText];
            self.topItem.numberLabel.text = self.money;
        }else if(!self.money){
            self.money = buttonText;
            self.topItem.numberLabel.text = buttonText;
        }
    }
}
/**
 *  计算汇率，并返回结果
 */
-(void)calculateResult
{
    if (!self.money) return ;
    NSString *money = self.money;
    //获取要计算的币种的汇率
    NSString *rate = [self.db selectRateWithCode:self.topItem.exrateButton.titleLabel.text];
    NSString *resultRate = [self.db selectRateWithCode:self.buttomItem.exrateButton.titleLabel.text];
    double result = [money intValue] * [resultRate doubleValue] / [rate doubleValue];
    //计算结果
    NSString *resultStr = [NSString stringWithFormat:@"%f",result];
    //截取小数点后两位
    NSRange resultRange = [resultStr rangeOfString:@"."];
    self.buttomItem.numberLabel.text = [resultStr substringToIndex:resultRange.location + 3];
}

/**
 *  点击导航右边按钮
 */
-(void)rightBarButtonItemClick
{
    NSString *topExrateStr = self.topItem.exrateButton.titleLabel.text;
    NSString *buttomExrateStr = self.buttomItem.exrateButton.titleLabel.text;
    [self.topItem.exrateButton setTitle:buttomExrateStr forState:UIControlStateNormal];
    [self.buttomItem.exrateButton setTitle:topExrateStr forState:UIControlStateNormal];
}
/**
 *  选择币种按钮时调用
 */
-(void)exrateButtonClick:(UIButton *)button
{
    self.exrateButton = button;
    XMCurrencySelector *currencyController = [[XMCurrencySelector alloc] init];
    currencyController.currentExrate = button.titleLabel.text;
    currencyController.delegate = self;
    [self.navigationController pushViewController:currencyController animated:YES];
}

#pragma mark - 代理回调方法
-(void)currencySelectorCallBack:(NSString *)currencyName
{
    [self.exrateButton setTitle:currencyName forState:UIControlStateNormal];
}

@end

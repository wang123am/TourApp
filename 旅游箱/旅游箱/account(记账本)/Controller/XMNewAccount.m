//
//  XMNewAccount.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/26.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMNewAccount.h"
#import "XMNewAccountGrid.h"
#import "XMNewAccountItem.h"
#import "XMNewAccountPictItem.h"
#import "XMSetTourButton.h"
#import "XMCurrencySelector.h"
#import "XMCalendar.h"
#import "XMExrateKeyboard.h"
#import "XMNewAccountComments.h"
#import "XMAccountDb.h"
#import "XMTimer.h"
#import "XMNewAccountPhoto.h"
#import "UIImage+XM.h"
#import "XMSelectPhoto.h"

#define appHeight self.view.frame.size.height
#define appWidth self.view.frame.size.width
#define margin 10
#define itemW appWidth-2*margin
#define itemH 50
#define keyboardH 200



typedef enum {
    XMNewAccountNonePhoto = 0,
    XMNewAccountHavePhoto
}XMNewAccountPhotoType;

@interface XMNewAccount ()<XMNewAccountItemDelegate,XMCurrencySelectorDelegate,XMCalendarDelegate,XMExrateKeyboardDelegate,XMNewAccountCommentsDelegate,XMNewAccountPictItemDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,XMNewAccountPhotoDelegate>
/** 头部布局*/
@property (nonatomic,weak) XMNewAccountGrid *headerView;
/** 金额条目*/
@property (nonatomic,weak) XMNewAccountItem *moneyItem;
/** 币种条目*/
@property (nonatomic,weak) XMNewAccountItem *exrateItem;
/** 日期条目*/
@property (nonatomic,weak) XMNewAccountItem *dateItem;
/** 备注条目*/
@property (nonatomic,weak) XMNewAccountItem *commentsItem;
/** 图片条目*/
@property (nonatomic,weak) XMNewAccountPictItem *pictItem;
/** 保存按钮*/
@property (nonatomic,weak) XMSetTourButton *buttomView;
/** 保存金额数目*/
@property (nonatomic,copy) NSString *money;
/** 键盘按钮*/
@property (nonatomic,weak) UIButton *keyButton;
/** 键盘*/
@property (nonatomic,weak) XMExrateKeyboard *keyboard;
/** 图片按钮弹出框*/
@property (nonatomic,weak) UIActionSheet *sheet;
/** 判断有无配图*/
@property (nonatomic,assign)XMNewAccountPhotoType photoType;
@end

@implementation XMNewAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增消费";
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    //1.添加头部导航
    [self addHeaderView];
    //2.添加中间条目
    [self addCententView];
}

-(void)addHeaderView
{
    XMNewAccountGrid *headerView = [[XMNewAccountGrid alloc] initWithFrame:CGRectMake(0, 64, appWidth, 100)];
    self.headerView = headerView;
    [self.view addSubview:headerView];
}
-(void)addCententView
{
    //添加金额条目
    XMNewAccountItem *moneyItem = [XMNewAccountItem itemWithTitle:@"金额" details:@"0" isShowArrow:NO];
    self.moneyItem = moneyItem;
    moneyItem.delegate = self;
    moneyItem.type = moneyItemTag;
    moneyItem.detailsLabel.textColor = [UIColor redColor];
    moneyItem.frame = CGRectMake(margin, CGRectGetMaxY(self.headerView.frame)+5, itemW, itemH);
    [self.view addSubview:moneyItem];
    //添加币种条目
    XMNewAccountItem *exrateItem = [XMNewAccountItem itemWithTitle:@"币种" details:@"CNY" isShowArrow:YES];
    self.exrateItem = exrateItem;
    exrateItem.delegate = self;
    exrateItem.type = exrateItemTag;
    exrateItem.frame = CGRectMake(margin, CGRectGetMaxY(moneyItem.frame)+1, itemW, itemH);
    [self.view addSubview:exrateItem];
    //添加日期条目
    XMNewAccountItem *dateItem = [XMNewAccountItem itemWithTitle:@"日期" details:[XMTimer toDay] isShowArrow:YES];
    self.dateItem = dateItem;
    dateItem.delegate = self;
    dateItem.type = dateItemTag;
    dateItem.frame = CGRectMake(margin, CGRectGetMaxY(exrateItem.frame) + margin, itemW, itemH);
    [self.view addSubview:dateItem];
    //添加备注条目
    XMNewAccountItem *commentsItem = [XMNewAccountItem itemWithTitle:@"备注" details:@"" isShowArrow:NO];
    self.commentsItem = commentsItem;
    commentsItem.delegate = self;
    commentsItem.type = commentsItemTag;
    commentsItem.detailsLabel.font = [UIFont systemFontOfSize:12];
    commentsItem.detailsLabel.numberOfLines = 0;
    commentsItem.frame = CGRectMake(margin, CGRectGetMaxY(dateItem.frame)+1, itemW, itemH);
    [self.view addSubview:commentsItem];
    //添加图片条目
    XMNewAccountPictItem *pictItem = [[XMNewAccountPictItem alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(commentsItem.frame) +1, itemW, itemH)];
    pictItem.delegate = self;
    self.pictItem = pictItem;
    [self.view addSubview:pictItem];
    //添加按钮
    XMSetTourButton *buttomView = [XMSetTourButton buttonWithTitle:@"保存" normalImg:[UIImage imageNamed:@"travel_page_start_travel"] presseed:[UIImage imageNamed:@"travel_page_start_travel_pressed"] isEnableImg:YES];
    [buttomView addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    buttomView.frame = CGRectMake(margin, CGRectGetMaxY(pictItem.frame)+margin, itemW, itemH);
    self.buttomView = buttomView;
    [self.view addSubview:buttomView];
}

-(void)itemClickCallBack:(XMNewAccountItemTag)type
{
    switch (type) {
        case moneyItemTag:
        {
            [self setupItemView];
            XMExrateKeyboard *keyboard = [[XMExrateKeyboard alloc] initWithFrame:CGRectMake(0, appHeight-keyboardH, appWidth, keyboardH)];
            self.keyboard = keyboard;
            UIButton * keyButton = keyboard.otherButtonArray[keyboard.otherButtonArray.count-1];
            self.keyButton = keyButton;
            [keyButton setImage:[UIImage imageNamed:@"account_page_calc_cancel_down"] forState:UIControlStateHighlighted];
            [keyButton setImage:[UIImage imageNamed:@"account_page_calc_cancel_up"] forState:UIControlStateNormal];
            keyboard.delegate = self;
            [self.view addSubview:keyboard];
            break;
        }
        case exrateItemTag:
        {
            XMCurrencySelector *currency = [[XMCurrencySelector alloc] init];
            currency.currentExrate = self.exrateItem.detailsLabel.text;
            currency.delegate = self;
            [self.navigationController pushViewController:currency animated:YES];
            break;
        }
        case dateItemTag:
        {
            XMCalendar *calendar = [[XMCalendar alloc] init] ;
            calendar.delegate = self;
            [self.navigationController pushViewController:calendar animated:YES];
        }
            break;
        case commentsItemTag:
        {
            XMNewAccountComments *commentController = [[XMNewAccountComments alloc] init];
            commentController.controllerTitle = @"备注";
            commentController.text = [self.commentsItem.detailsLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            commentController.delegate = self;
            [self.navigationController pushViewController:commentController animated:YES];
            break;
        }
    }
}

/**
 *  设置点击金额时属性
 */
-(void)setupItemView
{
    self.exrateItem.alpha = 0.7;
    self.exrateItem.userInteractionEnabled = NO;
    self.dateItem.alpha = 0.7;
    self.dateItem.userInteractionEnabled = NO;
    self.commentsItem.alpha = 0.7;
    self.commentsItem.userInteractionEnabled = NO;
    self.pictItem.alpha = 0.7;
    self.pictItem.userInteractionEnabled = NO;
    self.moneyItem.layer.borderColor = [UIColor grayColor].CGColor;
    self.moneyItem.layer.borderWidth = 1;
    self.buttomView.enabled = NO;
}
/**
 *  取消点击金额时的属性
 */
-(void)cancelItemView
{
    self.exrateItem.alpha = 1;
    self.exrateItem.userInteractionEnabled = YES;
    self.dateItem.alpha = 1;
    self.dateItem.userInteractionEnabled = YES;
    self.commentsItem.alpha = 1;
    self.commentsItem.userInteractionEnabled = YES;
    self.pictItem.alpha = 1;
    self.pictItem.userInteractionEnabled = YES;
    //添加覆盖层
    self.moneyItem.layer.borderColor = [UIColor whiteColor].CGColor;
    self.moneyItem.layer.borderWidth = 1;
}

/**
 *  从相册中选择了图片后调用
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            [self.pictItem.pictButton setImage:image forState:UIControlStateNormal];
            self.photoType = XMNewAccountHavePhoto;
        }];
    }
   
}

/**
 *  点击保存按钮
 *  这里主要保存图片到document文件，和保存数据到数据库
 */
-(void)saveButtonClick
{
    //1.获取消费类型
    NSString *type = self.headerView.selectItem.nameLabel.text;
    //2.获取消费金额
    NSString *money = self.moneyItem.detailsLabel.text;
    //3.获取消费币种
    NSString *exrate = self.exrateItem.detailsLabel.text;
    //4.获取消费日期
    NSString *date = self.dateItem.detailsLabel.text;
    //5.获取消费备注
    NSString *comments = self.commentsItem.detailsLabel.text;
    //6.获取消费图片
    UIImage *image = [self.pictItem.pictButton imageForState:UIControlStateNormal];
    NSString *photoPath = nil;
    if (self.photoType) {
        //7.保存图片到document
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil){
            data = UIImageJPEGRepresentation(image, 1.0);
        } else {
            data = UIImagePNGRepresentation(image);
        }
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"AccountImg"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        photoPath = [DocumentsPath stringByAppendingString:[XMTimer currentTime:@"yyyyMMddHHmmss"]];
        [fileManager createFileAtPath:photoPath contents:data attributes:nil];
    } else {
        photoPath = @"";
    }
    
    //8.保存全部内容到数据库
    XMAccountDb *db = [[XMAccountDb alloc] init];
    NSString *code = [db selectMoneySymbolWithCode:exrate];
    [db insertToAccountWithType:type money:money exrate:exrate code:code date:date comments:comments imgPath:photoPath];
    NSLog(@"新增记账条目%@---%@---%@---%@---%@----%@",type,money,exrate,date,comments,photoPath);
    
    if ([self.delegate respondsToSelector:@selector(saveButtonClick)]) {
        [self.delegate saveButtonClick];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -代理回调
-(void)currencySelectorCallBack:(NSString *)currencyName
{
    self.exrateItem.detailsLabel.text = currencyName;
}
-(void)seletorDateCallBack:(NSString *)date viewTag:(int)tag
{
    self.dateItem.detailsLabel.text = date;
}
/**
 *  点击键盘按钮时调用
 */
-(void)keyboardButtonClick:(NSString *)buttonText
{
    if(buttonText==nil){
        if (self.money) {
            self.moneyItem.detailsLabel.text = self.money;
            self.buttomView.enabled = YES;
        }
        [self cancelItemView];
        [self.keyboard removeFromSuperview];
    } else if([buttonText isEqualToString:@"0"]){
        //按下0键
        if (self.money && self.money.length < 9) {
            self.money = [NSString stringWithFormat:@"%@%@",self.money,buttonText];
            self.moneyItem.detailsLabel.text = self.money;
        } else if(!self.money){
            self.money = nil;
            self.moneyItem.detailsLabel.text = @"0";
        }
    } else if([buttonText isEqualToString:@"C"]){
        //按下取消键
        self.money = nil;
        self.moneyItem.detailsLabel.text = @"0";
    } else {
        //按下1-9
        if (self.money && self.money.length < 9) {
            self.money = [NSString stringWithFormat:@"%@%@",self.money,buttonText];
            self.moneyItem.detailsLabel.text = self.money;
        }else if(!self.money){
            self.money = buttonText;
            self.moneyItem.detailsLabel.text = buttonText;
        }
    }
    
    //根据金额是否为0进行切换图片
    if ([self.moneyItem.detailsLabel.text isEqualToString:@"0"]) {
        [self.keyButton setImage:[UIImage imageNamed:@"account_page_calc_cancel_down"] forState:UIControlStateHighlighted];
        [self.keyButton setImage:[UIImage imageNamed:@"account_page_calc_cancel_up"] forState:UIControlStateNormal];
    } else {
        [self.keyButton setImage:[UIImage imageNamed:@"account_page_calc_ok_down"] forState:UIControlStateHighlighted];
        [self.keyButton setImage:[UIImage imageNamed:@"account_page_calc_ok"] forState:UIControlStateNormal];
    }
}
/**
 *  备注内容
 */
-(void)commentsCallBackWithText:(NSString *)text
{
    self.commentsItem.detailsLabel.text = text;
}
/**
 *  点击照片按钮
 */
-(void)pictButtonCallBack
{
    if (self.photoType) {
        //有配图
        XMNewAccountPhoto *photoController = [[XMNewAccountPhoto alloc] init];
        photoController.delegate = self;
        photoController.photoImg = [self.pictItem.pictButton imageForState:UIControlStateNormal];
        [self.navigationController pushViewController:photoController animated:YES];
    } else {
        //没配图
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片路径" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
        [sheet showInView:self.view];
    }
}

/**
 *  底部弹出框按钮点击
 */
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //从相册选择图片
        [XMSelectPhoto openLocalPhotoWithTager:self];
    }else if(buttonIndex == 1){
        //打开相机拍照
        [XMSelectPhoto takePhotoWithTager:self];
    }else if(buttonIndex == 2){
        //取消
    }
}

/**
 *  删除图片执行这个方法
 */
-(void)deletePhotoCallBack
{
    [self.pictItem.pictButton setImage:[UIImage scaleToSize:[UIImage imageNamed:@"account_add_page_add_pic"] size:CGSizeMake(40, 40)] forState:UIControlStateNormal];
    self.photoType = XMNewAccountNonePhoto;
}
@end

//
//  XMTravelassistantNewHotelController.m
//  旅游箱
//
//  Created by 梁亦明 on 15/10/28.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantNewHotelController.h"
#import "XMTravelassistantTouristItem.h"
#import "XMTravelassistantTouristPlaceItem.h"
#import "XMTravelassistantTouristTicketItem.h"
#import "UIView+XM.h"
#import "UILabel+XM.h"
#import "UIImage+XM.h"
#import "XMTravelassistantMapController.h"
#import "XMExrateKeyboard.h"
#import "XMCurrencySelector.h"
#import "XMSetTravelTool.h"
#import "XMAccountDb.h"
#import "UIBarButtonItem+XM.h"
#import "XMTravelassistantDb.h"
#import "XMTravelassistantTouristModel.h"
#import "XMNewAccountPhoto.h"
#import "XMSelectPhoto.h"
#import "XMTravelassistantHotelModel.h"
#import "XMTimer.h"

#define viewWidth self.view.frame.size.width
#define viewHeight self.view.frame.size.height
#define keyboardH 200
typedef enum {
    XMNewAccountNonePhoto = 0,
    XMNewAccountHavePhoto
}XMNewAccountPhotoType;
@interface XMTravelassistantNewHotelController ()<XMTravelassistantMapDelegate,XMExrateKeyboardDelegate,XMCurrencySelectorDelegate,XMNewAccountPhotoDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
/** 自定义键盘*/
@property (nonatomic,weak) XMExrateKeyboard *keyboard;
/** 取消按钮*/
@property (nonatomic,weak) UIButton *keyButton;
/** 保存输入金额*/
@property (nonatomic,copy) NSString * money;
/** 景点名称*/
@property (nonatomic,weak) XMTravelassistantTouristItem *nameView;
/** 电话*/
@property (nonatomic,weak) XMTravelassistantTouristItem *phoneView;
/** 地理位置*/
@property (nonatomic,weak) XMTravelassistantTouristItem *pointView;
/** 自动获取*/
@property (nonatomic,weak) XMTravelassistantTouristPlaceItem *placeItem;
/** 添加到记账本*/
@property (nonatomic,weak) UILabel *addAccountLabel;
/** 价格*/
@property (nonatomic,weak) XMTravelassistantTouristTicketItem *moneyItem;
/** 币种*/
@property (nonatomic,weak) XMTravelassistantTouristTicketItem *exrateItem;
/** 照片*/
@property (nonatomic,weak) UIButton *photoButton;
/** 判断有无配图*/
@property (nonatomic,assign)XMNewAccountPhotoType photoType;
@end

@implementation XMTravelassistantNewHotelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.navigationItem.title = @"添加酒店";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"account_page_title_right_finish"] selectorImg:[UIImage imageNamed:@"account_page_title_right_finish_press"] target:self action:@selector(rightBarButtonItemClick)];
    
    CGFloat margin = 20;
    CGFloat itemHeight = 40;
    CGFloat itemWidth = viewWidth - 2*margin;
    
    // 酒店名
    XMTravelassistantTouristItem *nameView = [XMTravelassistantTouristItem touristItemWithTitle:@"酒店名称"];
    nameView.frame = CGRectMake(margin, margin + 64, itemWidth, itemHeight);
    self.nameView = nameView;
    [self.view addSubview:nameView];
    
    // 电话
    XMTravelassistantTouristItem *phoneView = [XMTravelassistantTouristItem touristItemWithTitle:@"酒店电话"];
    phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    phoneView.frame = CGRectMake(margin, CGRectGetMaxY(nameView.frame)+1, itemWidth, itemHeight);
    self.phoneView = phoneView;
    [self.view addSubview:phoneView];
    
    //地理位置
    XMTravelassistantTouristItem *pointView = [XMTravelassistantTouristItem touristItemWithTitle:@"地理位置"];
    pointView.textField.font = [UIFont systemFontOfSize:10];
    pointView.frame = CGRectMake(margin, CGRectGetMaxY(phoneView.frame) + 10, itemWidth, itemHeight);
    self.pointView = pointView;
    [self.view addSubview:pointView];
    //添加自动获取
    XMTravelassistantTouristPlaceItem *placeItem = [[XMTravelassistantTouristPlaceItem alloc] initWithFrame:CGRectMake(295, CGRectGetMaxY(pointView.frame) + 5, 60, 20)];
    [placeItem OnViewClickListener:self action:@selector(placeItemClick)];
    self.placeItem = placeItem;
    [self.view addSubview:placeItem];
    
    //添加酒店话费
    CGFloat ticketLabelY = CGRectGetMaxY(placeItem.frame) + 10;
    CGFloat ticketLabelX = 80;
    UILabel * ticketLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin+10, ticketLabelY, ticketLabelX, itemHeight)];
    ticketLabel.text = @"酒店花费";
    ticketLabel.textColor = [UIColor grayColor];
    ticketLabel.font = [UIFont systemFontOfSize:13];
    ticketLabel.textAlignment = NSTextAlignmentLeft;
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
    
    // 照片墙
    UILabel * photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin + 10, CGRectGetMaxY(exrateItem.frame) + 10, ticketLabelX, itemHeight)];
    photoLabel.text = @"照片墙";
    photoLabel.textColor = [UIColor grayColor];
    photoLabel.font = [UIFont systemFontOfSize:13];
    photoLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:photoLabel];
    
    // 照片按钮
    UIButton *photoButton = [[UIButton alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(photoLabel.frame) + 5, 100, 100)];
    self.photoButton = photoButton;
    [photoButton addTarget:self action:@selector(photoButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [photoButton setImage:[UIImage imageNamed:@"camera_default"] forState:UIControlStateNormal];
    [self.view addSubview:photoButton];
}
#pragma mark - delegate
-(void) travelassistantMapSelectCity:(NSString *)city {
    self.pointView.textField.text = city;
}

-(void)keyboardButtonClick:(NSString *)buttonText {
    
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

-(void) currencySelectorCallBack:(NSString *)currencyName {
    self.exrateItem.rightLabel.text = currencyName;
}
-(void)deletePhotoCallBack {
    [self.photoButton setImage:[UIImage scaleToSize:[UIImage imageNamed:@"camera_default"] size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
    self.photoType = XMNewAccountNonePhoto;
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
            [self.photoButton setImage:image forState:UIControlStateNormal];
            self.photoType = XMNewAccountHavePhoto;
        }];
    }
    
}
#pragma mark-  action event
/**
 *  点击保存
 */
-(void) rightBarButtonItemClick{
    //获取酒店
    NSString *viewStr = [self.nameView.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    // 获取地理位置
    NSString *pointStr = [self.pointView.textField.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([viewStr isEqualToString:@""]) {
        [XMSetTravelTool showToast:@"酒店名称不能空" view:self.view];
    } else if ([pointStr isEqualToString:@""]) {
        [XMSetTravelTool showToast:@"地理位置不能空" view:self.view];
    } else {
        // 保存数据

        // 获取电话
        NSString *phoneStr = [self.phoneView.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // 获取门票
        NSString *moneyStr = self.moneyItem.rightLabel.text;
        // 获取门票
        NSString *exrateStr = self.exrateItem.rightLabel.text;
        
        // 保存图片
        UIImage *image = [self.photoButton imageForState:UIControlStateNormal];
        NSString *photoPath = @"";
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
            photoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HotelImg"];
            //文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //把刚刚图片转换的data对象拷贝至沙盒中 并保存
//            [fileManager createDirectoryAtPath:photoPath withIntermediateDirectories:YES attributes:nil error:nil];
//            photoPath = [DocumentsPath stringByAppendingString:[XMTimer currentTime:@"yyyyMMddHHmmss"]];
            [fileManager createFileAtPath:photoPath contents:data attributes:nil];
        }
        
        // 保存到数据库
        XMTravelassistantHotelModel *model = [[XMTravelassistantHotelModel alloc] init];
        model.hotelName = viewStr;
        model.hotelPhone = phoneStr;
        model.hotelLocation = pointStr;
        model.tourMoney = moneyStr;
        model.tourExrate = exrateStr;
        model.cityType = self.cityType;
        model.imgPath = photoPath;
        XMTravelassistantDb *db = [[XMTravelassistantDb alloc] init];
        [db insertHotelWithModel:model];
        // 更新行程助手的数据
        [db upDateTravelassistantWithColmnName:@"hotel" colmnValue:viewStr cityType:self.cityType];
        
        // 代理回调
        if ([self.delegate respondsToSelector:@selector(hotelSetupCallBackWithModel:)]) {
            [self.delegate hotelSetupCallBackWithModel:model];
        }
        [self.navigationController popViewControllerAnimated:true];
    }
}

/**
 *  点击位置
 */
-(void) placeItemClick {
    [self closeKeyboard];
    XMTravelassistantMapController *mapController = [[XMTravelassistantMapController alloc] init];
    mapController.delegate = self;
    [self.navigationController pushViewController:mapController animated:YES];
}

/**
 *  添加到记账本
 */
-(void) addAccountClick {
    [self closeKeyboard];
    if ([self.moneyItem.rightLabel.text intValue]) {
        //币种
        NSString *exrate = self.exrateItem.rightLabel.text;
        //获取符号
        XMAccountDb *accountdb = [[XMAccountDb alloc] init];
        NSString *code = [accountdb selectMoneySymbolWithCode:exrate];
        //金额
        NSString *money = self.moneyItem.rightLabel.text;
        [accountdb insertToAccountWithType:@"住宿" money:money exrate:exrate code:code date:self.date comments:@"" imgPath:@""];
        [XMSetTravelTool showToast:@"添加记账成功" view:self.view];
    } else {
        [XMSetTravelTool showToast:@"价格不能为0" view:self.view];
    }
}

/**
 *  点击价格
 */
-(void)moneyItemClick {
    
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
 *  点击币种
 */
-(void) exrateItemClick {
    [self closeKeyboard];
    XMCurrencySelector *currency = [[XMCurrencySelector alloc] init];
    currency.currentExrate = self.exrateItem.rightLabel.text;
    currency.delegate = self;
    [self.navigationController pushViewController:currency animated:YES];
}


/**
 *  点击图片按钮
 */
-(void) photoButtonDidClick: (UIButton *) photoButton {
    if (self.photoType) {
        //有配图
        XMNewAccountPhoto *photoController = [[XMNewAccountPhoto alloc] init];
        photoController.delegate = self;
        photoController.photoImg = [self.photoButton imageForState:UIControlStateNormal];
        [self.navigationController pushViewController:photoController animated:YES];
    } else {
        //没配图
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片路径" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
        [sheet showInView:self.view];
    }
}

#pragma mark - private methods
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.view isExclusiveTouch]) {
        [self closeKeyboard];
    }
}

-(void)closeKeyboard
{
    [self.nameView.textField resignFirstResponder];
    [self.phoneView.textField resignFirstResponder];
    [self.pointView.textField resignFirstResponder];
}

/**
 *  当用户点击金额时取消其他控件点击
 */
-(void)userInterface:(BOOL)flag
{
    self.nameView.userInteractionEnabled = flag;
    self.phoneView.userInteractionEnabled = flag;
    self.pointView.userInteractionEnabled = flag;
    self.placeItem.userInteractionEnabled = flag;
    self.addAccountLabel.userInteractionEnabled = flag;
    self.exrateItem.userInteractionEnabled = flag;
    self.photoButton.userInteractionEnabled = flag;
}
@end

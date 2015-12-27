//
//  XMTravelassistantHotelController.m
//  旅游箱
//
//  Created by 梁亦明 on 15/10/27.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantHotelController.h"
#import "XMTravelassistantDb.h"
#import "XMTravelassistantSetView.h"
#import "XMTravelassistantHotelView.h"
#import "XMTravelassistantHotelModel.h"
#import "XMTravelassistantNewHotelController.h"
#import "UIBarButtonItem+XM.h"

@interface XMTravelassistantHotelController () <XMTravelassistantSetViewDelegate, XMTravelassistantHotelViewDelegate,XMTravelassistantNewHotelControllerDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) XMTravelassistantDb *db;
@property (nonatomic,weak) XMTravelassistantSetView *setView;
@property (nonatomic,weak) XMTravelassistantHotelView *hotelView;
// 删除按钮
@property (nonatomic,strong) UIBarButtonItem *deleteButton;
@end

@implementation XMTravelassistantHotelController

#pragma mark - 初始化view
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"酒店住宿";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *deleteButton = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"travelassistant_page_dialog_page_item_delete"] selectorImg:nil target:self action:@selector(deleteButtonDidClick)];
    self.deleteButton = deleteButton;

    //判断当前数据库是否有记录
    XMTravelassistantDb *db = [[XMTravelassistantDb alloc] init];
    self.db = db;
    //创建数据表,添加数据到笔记表中
    [self.db createHotelTable];
    
    [self showSetupView];
    //显示tableView
    [self showHotelView];
    XMTravelassistantHotelModel *model = [db selectHotelWithCityType:self.cityType];
    if (model.hotelName) {
        self.setView.hidden = true;
        self.hotelView.hidden = false;
        self.hotelView.model = model;
        self.navigationItem.rightBarButtonItem = deleteButton;
    } else {
        self.setView.hidden = false;
        self.hotelView.hidden = true;
    }
}

-(void) showSetupView {
    XMTravelassistantSetView *setView = [XMTravelassistantSetView setViewWithCenterImg:[UIImage imageNamed:@"hotel_nodata"] buttonNomalImg:[UIImage imageNamed:@"hotel_page_add_viewpoint_normal"] buttonHigImg:[UIImage imageNamed:@"hotel_page_add_viewpoint_press"]];
    setView.frame = self.view.frame;
    setView.delegate = self;
    self.setView = setView;
    [self.view addSubview:setView];
}

-(void) showHotelView {
    XMTravelassistantHotelView *hotelView = [[XMTravelassistantHotelView alloc] initWithFrame: CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    hotelView.delegate = self;
    self.hotelView = hotelView;
    [self.view addSubview:hotelView];
}


#pragma mark - 点击事件
-(void) deleteButtonDidClick {
    //显示dialog
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定要删除酒店信息吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除",nil];
    [alertView show];
}

#pragma mark - 代理
-(void)travelassistantSetViewButtonClick {
    XMTravelassistantNewHotelController *newHotel = [[XMTravelassistantNewHotelController alloc] init];
    newHotel.delegate = self;
    newHotel.date = self.date;
    newHotel.cityType = self.cityType;
    [self.navigationController pushViewController:newHotel animated:true];
}

-(void)hotelSetupCallBackWithModel:(XMTravelassistantHotelModel *)model {
    self.setView.hidden = true;
    self.hotelView.hidden = false;
    self.hotelView.model = model;
    self.navigationItem.rightBarButtonItem = self.deleteButton;
}

-(void)phoneButtonDidClick:(NSString *)phone {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        // 删除数据库
        XMTravelassistantDb *db = [[XMTravelassistantDb alloc] init];
        [db deleteHotelWithCityType:self.cityType];
        
        // 更新
        [db upDateTravelassistantWithColmnName:@"hotel" colmnValue:@"暂未填写" cityType:self.cityType];
        
        self.setView.hidden = false;
        self.hotelView.hidden = true;
    
        self.navigationItem.rightBarButtonItems = @[];
    }
}


@end

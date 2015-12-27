//
//  XMTravelassistantHotelView.m
//  旅游箱
//
//  Created by 梁亦明 on 15/10/27.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantHotelView.h"
@interface XMTravelassistantHotelView()
/**
 *  背景图
 */
@property (nonatomic,weak) UIImageView *bgImage;
/**
 *  酒店名
 */
@property (nonatomic,weak) UILabel *hotelName;
/**
 *  电话
 */
@property (nonatomic,weak) UILabel *hotelDetail;
/**
 *  电话按钮
 */
@property (nonatomic,weak) UIButton *phoneButton;
/**
 *  分割线1
 */
@property (nonatomic,weak) UIView *line1View;

/**
 *  位置
 */
@property (nonatomic,weak) UILabel *locationLabel;

/**
 分割线2
 */
@property (nonatomic,weak) UIView *line2View;

/**
 *  房间价格
 */
@property (nonatomic,weak) UILabel *roomPrice;

/**
 *  币种
 */
@property (nonatomic,weak) UILabel *tourExrate;
@end

@implementation XMTravelassistantHotelView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat width = self.frame.size.width;
        CGFloat margin = 20;
        // 添加图片
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 188)];
//        bgImage.contentMode = UIViewContentModeScaleAspectFit;
        self.bgImage = bgImage;
        bgImage.image = [UIImage imageNamed:@"hotel_default"];
        [self addSubview:bgImage];
        
        // 添加酒店
        UILabel *hotelName = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(bgImage.frame) + margin, 280, 20)];
        self.hotelName = hotelName;
        hotelName.textAlignment = NSTextAlignmentLeft;
        hotelName.textColor = [UIColor grayColor];
        hotelName.font = [UIFont systemFontOfSize:15];
        [self addSubview:hotelName];
        
        // 电话
        UILabel *hotelDetail = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(hotelName.frame) + margin*0.5, 280, 20)];
        self.hotelDetail = hotelDetail;
        hotelDetail.text = @"暂未设置";
        hotelDetail.textAlignment = NSTextAlignmentLeft;
        hotelDetail.textColor = [UIColor lightGrayColor];
        hotelDetail.font = [UIFont systemFontOfSize:13];
        [self addSubview:hotelDetail];
        
        // 电话图标
        UIButton *phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hotelDetail.frame)+margin, CGRectGetMaxY(bgImage.frame) + margin, 50, 50)];
        self.phoneButton = phoneButton;
        [phoneButton setImage:[UIImage imageNamed:@"setting_page_call_us_icon.png"] forState:UIControlStateNormal];
        [phoneButton addTarget:self action:@selector(phoneButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:phoneButton];
        
        // 分割线
        UIView *line1View = [[UIView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(hotelDetail.frame) + margin, width - 2*margin, 1)];
        self.line1View = line1View;
        line1View.backgroundColor = [UIColor lightGrayColor];
        line1View.alpha = 0.2;
        [self addSubview:line1View];
        
        // 位置
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(line1View.frame)+margin, width-2*margin, 20)];
        self.locationLabel = locationLabel;
        locationLabel.textColor = [UIColor grayColor];
        locationLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:locationLabel];
        
        // 分割线2
        UIView *line2View = [[UIView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(locationLabel.frame) + margin, width - 2*margin, 1)];
        self.line2View = line2View;
        line2View.backgroundColor = [UIColor lightGrayColor];
        line2View.alpha = 0.2;
        [self addSubview:line2View];
        
        // 房间价格
        UILabel *roomPrice = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(line2View.frame)+margin, width-2*margin, 20)];
        roomPrice.textColor = [UIColor grayColor];
        roomPrice.font = [UIFont systemFontOfSize:15];
        self.roomPrice = roomPrice;
        [self addSubview:roomPrice];
        
        // 币种
        UILabel *tourExrate = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(roomPrice.frame)+margin*0.5, width-2*margin, 20)];
        tourExrate.textColor = [UIColor grayColor];
        tourExrate.font = [UIFont systemFontOfSize:15];
        self.tourExrate = tourExrate;
        [self addSubview:tourExrate];
        
    }
    return self;
}



-(void)setModel:(XMTravelassistantHotelModel *)model {
    
    _model = model;
    
    
    // 设置图片
    if (![model.imgPath isEqualToString:@""]) {
        NSString *photoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HotelImg"];
        self.bgImage.image = [UIImage imageWithContentsOfFile:photoPath];
    } else {
        self.bgImage.image = [UIImage imageNamed:@"hotel_default"];
    }
    // 设置酒店
    self.hotelName.text = model.hotelName;
    // 设置电话，右边电话按钮
    if (![model.hotelPhone isEqualToString:@""]) {
        self.hotelDetail.text = model.hotelPhone;
        [self.phoneButton setImage:[UIImage imageNamed:@"emergency_rescue_child_item_tell_icon"] forState:UIControlStateNormal];
    } else {
        self.hotelDetail.text = @"暂未填写";
        [self.phoneButton setImage:[UIImage imageNamed:@"setting_page_call_us_icon.png"] forState:UIControlStateNormal];
        self.phoneButton.userInteractionEnabled = false;
    }
    
    // 设置位置
    if (model.hotelLocation) {
        self.locationLabel.text = model.hotelLocation;
    }
    
    // 设置房间价钱和币种
    if (![model.tourMoney isEqualToString:@"0"]) {
        self.roomPrice.text = [NSString stringWithFormat:@"房间价格：%@",model.tourMoney];
        self.tourExrate.text = [NSString stringWithFormat:@"币种：%@",model.tourExrate];
    } else {
        self.line2View.hidden = true;
        self.roomPrice.hidden = true;
        self.tourExrate.hidden = true;
    }
}


-(void) phoneButtonDidClick {
    if ([self.delegate respondsToSelector:@selector(phoneButtonDidClick:)]) {
        [self.delegate phoneButtonDidClick:self.hotelDetail.text];
    }
}

@end

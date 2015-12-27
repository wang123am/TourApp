//
//  XMTravelassitstantTouristCell.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/11.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantTouristCell.h"
#import "XMTravelassistantTouristModel.h"
#import "UIImage+XM.h"
#define rowHeight 75
#define buttomHeight 10
#define rowWidth 375
@interface XMTravelassistantTouristCell ()
@property (nonatomic,weak) UIView *centerView;
/** 左边图片*/
@property (nonatomic,weak) UIImageView *leftImage;
/** 左边图片数字*/
@property (nonatomic,weak) UILabel *numberLabel;
/** 景点名称*/
@property (nonatomic,weak) UILabel *nameLabel;
/** 景点位置*/
@property (nonatomic,weak) UILabel *placeLabel;
/** 金额*/
@property (nonatomic,weak) UILabel *moneyLabel;
/** 底部背景*/
@property (nonatomic,weak) UIImageView *buttomImg;
@end

@implementation XMTravelassistantTouristCell
+(instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *touristId = @"touristId";
    XMTravelassistantTouristCell *cell = [tableView dequeueReusableCellWithIdentifier:touristId];
    if (!cell)
        cell = [[XMTravelassistantTouristCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:touristId];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *centerView = [[UIView alloc] init];
        centerView.backgroundColor = [UIColor whiteColor];
        self.centerView = centerView;
        [self.contentView addSubview:centerView];
        
        UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewspot_page_list_position_bg"]];
        leftImage.contentMode = UIViewContentModeCenter;
        self.leftImage = leftImage;
        [self.centerView addSubview:leftImage];
        
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.textColor = [UIColor colorWithRed:103/255.0 green:185/255.0 blue:159/255.0 alpha:1];
        numberLabel.font = [UIFont systemFontOfSize:12];
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel = numberLabel;
        [self.centerView addSubview:numberLabel];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:13];
        self.nameLabel = nameLabel;
        [self.centerView addSubview:nameLabel];
        
        UILabel *placeLabel = [[UILabel alloc] init];
        placeLabel.text = @"暂无数据";
        placeLabel.textColor = [UIColor grayColor];
        placeLabel.font = [UIFont systemFontOfSize:9];
        self.placeLabel = placeLabel;
        [self.centerView addSubview:placeLabel];
        
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.textAlignment = NSTextAlignmentRight;
        moneyLabel.font = [UIFont systemFontOfSize:12];
        self.moneyLabel = moneyLabel;
        [self.centerView addSubview:moneyLabel];
        
        UIImageView *buttomImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_color_line"]];
        self.buttomImg = buttomImg;
        [self.contentView addSubview:buttomImg];
        
    }
    return self;
}

-(void)setModel:(XMTravelassistantTouristModel *)model
{
    //设置frame
    self.centerView.frame = CGRectMake(0, 0, rowWidth, rowHeight - buttomHeight);
    self.leftImage.frame = CGRectMake(0, 0, 50, rowHeight);
    self.numberLabel.frame = CGRectMake(0, -5, 50, rowHeight);
    
    CGFloat nameLabelX = CGRectGetMaxX(self.leftImage.frame);
    self.nameLabel.frame = CGRectMake(nameLabelX, 10, 200, 20);
    self.placeLabel.frame = CGRectMake(nameLabelX, CGRectGetMaxY(self.nameLabel.frame)+10, rowWidth-nameLabelX, 20);
    self.moneyLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 10, 100, 20);
    self.buttomImg.frame = CGRectMake(0, CGRectGetMaxY(self.centerView.frame), rowWidth, 10);
    //设置数据
    self.nameLabel.text = model.tourName;
    self.placeLabel.text = model.tourLocation;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@ %@",model.tourExrate,model.tourMoney];
}
-(void)setRow:(long)row
{
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",row];
}
@end

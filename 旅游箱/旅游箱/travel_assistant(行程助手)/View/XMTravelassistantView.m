//
//  XMTravelassistantView.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantView.h"
#import "XMTravelassistantCityView.h"
#import "XMTravelassistantItem.h"
#import "XMTravelassistantModel.h"
#import "UIView+XM.h"

#define viewWidth self.frame.size.width
#define viewHeight self.frame.size.height

@interface XMTravelassistantView ()
/** 添加城市*/
@property (nonatomic,weak) XMTravelassistantCityView *cityView;
@end

@implementation XMTravelassistantView
-(instancetype) initWithModel:(XMTravelassistantModel *)model dayNumber:(NSString *)dayNumber
{
    if (self = [super init]) {
        //添加标题
        XMTravelassistantTitleView *titleView = [XMTravelassistantTitleView viewWithTitle:model.time dayNumber:dayNumber];
        self.titleView = titleView;
        [self addSubview:titleView];
        //添加城市条目
        XMTravelassistantCityView *cityView = [XMTravelassistantCityView viewWithCity:model.city];
        self.cityView = cityView;
        [self addSubview:cityView];
        //添加当天消费条目
        XMTravelassistantItem *consumeItem = [XMTravelassistantItem itemWithIcon:[UIImage imageNamed:@"travelassistant_detail_page_account"] title:@"当天消费" detailsTitle:model.money];
        consumeItem.tag = 0;
        [consumeItem OnViewClickListener:self action:@selector(travelassistantItemClick:)];
        self.consumeItem = consumeItem;
        [self addSubview:consumeItem];
        //添加笔记提醒条目
        
        XMTravelassistantItem *noteItem = [XMTravelassistantItem itemWithIcon:[UIImage imageNamed:@"travelassistant_detail_page_note"] title:@"笔记提醒" detailsTitle:[NSString stringWithFormat:@"%d",model.noteCount]];
        noteItem.tag = 1;
        [noteItem OnViewClickListener:self action:@selector(travelassistantItemClick:)];
        self.noteItem = noteItem;
        [self addSubview:noteItem];
        //添加景点规划
        XMTravelassistantItem *sceneItem = [XMTravelassistantItem itemWithIcon:[UIImage imageNamed:@"travelassistant_detail_page_viewspot"] title:@"景点规划" detailsTitle:[NSString stringWithFormat:@"%d",model.touristCount]];
        sceneItem.tag = 2;
        [sceneItem OnViewClickListener:self action:@selector(travelassistantItemClick:)];
        self.sceneItem = sceneItem;
        [self addSubview:sceneItem];
        //添加酒店住宿
        XMTravelassistantItem *hotelItem = [XMTravelassistantItem itemWithIcon:[UIImage imageNamed:@"travelassistant_detail_page_hotel"] title:@"酒店住宿" detailsTitle:model.hotel];
        hotelItem.tag = 3;
        [hotelItem OnViewClickListener:self action:@selector(travelassistantItemClick:)];
        self.hotelItem = hotelItem;
        [self addSubview:hotelItem];
        //旅行日记
        XMTravelassistantItem *diaryItem = [XMTravelassistantItem itemWithIcon:[UIImage imageNamed:@"travelassistant_detail_page_photo"] title:@"旅行日记" detailsTitle:[NSString stringWithFormat:@"%d",model.diary]];
        diaryItem.tag = 4;
        [diaryItem OnViewClickListener:self action:@selector(travelassistantItemClick:)];
        self.diaryItem = diaryItem;
        [self addSubview:diaryItem];
    }
    return self;
}

/**
 *  点击条目时调用
 */
-(void)travelassistantItemClick:(UITapGestureRecognizer *)recognizer
{
    //获取superview的id
    NSInteger superViewId = [[recognizer.view superview] tag];
    //获取点击view的id
    NSInteger clickViewId = recognizer.view.tag;
    if ([self.delegate respondsToSelector:@selector(travelassistantItemClickWithSuperViewId:clickViewId:)]) {
        [self.delegate travelassistantItemClickWithSuperViewId:superViewId clickViewId:clickViewId];
    }
}

+(instancetype) viewWithModel:(XMTravelassistantModel *)model dayNumber:(NSString *)dayNumber
{
    return [[self alloc] initWithModel:model dayNumber:(NSString *)dayNumber];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat itemHeight = 50;
    CGFloat margin = 1;
    self.titleView.frame = CGRectMake(0, 0, viewWidth, itemHeight);
    self.cityView.frame = CGRectMake( 0, CGRectGetMaxY(self.titleView.frame) + margin, viewWidth, itemHeight);
    self.consumeItem.frame = CGRectMake(0, CGRectGetMaxY(self.cityView.frame) + margin, viewWidth, itemHeight);
    self.noteItem.frame = CGRectMake(0, CGRectGetMaxY(self.consumeItem.frame) + margin, viewWidth, itemHeight);
    self.sceneItem.frame = CGRectMake(0, CGRectGetMaxY(self.noteItem.frame) + margin, viewWidth, itemHeight);
    self.hotelItem.frame = CGRectMake(0, CGRectGetMaxY(self.sceneItem.frame) + margin, viewWidth, itemHeight);
    self.diaryItem.frame = CGRectMake(0, CGRectGetMaxY(self.hotelItem.frame) + margin, viewWidth, itemHeight);
}

-(void)setModel:(XMTravelassistantModel *)model
{
    [self.consumeItem setDetails:model.money];
    [self.noteItem setDetails:[NSString stringWithFormat:@"%d",model.noteCount]];
    [self.sceneItem setDetails:[NSString stringWithFormat:@"%d",model.touristCount]];
    [self.hotelItem setDetails:model.hotel];
    [self.diaryItem setDetails:[NSString stringWithFormat:@"%d",model.diary]];
}

- (void)setupDataWithTime:(NSString *)time point:(NSString *)point
{
    self.titleView.dateLabel.text = time;
    [self.cityView.cityButton setTitle:point forState:UIControlStateNormal];
}
@end

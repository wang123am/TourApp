//
//  XMTravelassistantItem.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantItem.h"
#define viewHeight self.frame.size.height
#define viewWidth self.frame.size.width
@interface XMTravelassistantItem ()
/** 左边图片*/
@property (nonatomic,weak) UIImageView *leftIcon;
/** 标题*/
@property (nonatomic,weak) UILabel *titleLabel;
/** 右边详情*/
@property (nonatomic,weak) UILabel *detailsLabel;
/** 右边图片*/
@property (nonatomic,weak) UIImageView *arrowRight;
@end

@implementation XMTravelassistantItem
-(instancetype) initWithIcon:(UIImage *)image title:(NSString *)title detailsTitle:(NSString *)details
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        //添加图标
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.image = image;
        leftIcon.contentMode = UIViewContentModeCenter;
        self.leftIcon = leftIcon;
        [self addSubview:leftIcon];
        
        //添加文字
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.alpha = 0.9;
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        
        UILabel *detailsLabel = [[UILabel alloc] init];
        detailsLabel.text = details;
        detailsLabel.font = [UIFont systemFontOfSize:11];
        detailsLabel.textColor = [UIColor grayColor];
        detailsLabel.textAlignment = NSTextAlignmentRight;
        self.detailsLabel = detailsLabel;
        [self addSubview:detailsLabel];
        
        UIImageView *arrowRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_money_choice_arrow"]];
        arrowRight.contentMode = UIViewContentModeCenter;
        self.arrowRight = arrowRight;
        [self addSubview:arrowRight];
    }
    return self;
}
+(instancetype) itemWithIcon:(UIImage *)image title:(NSString *)title detailsTitle:(NSString *)details
{
    return [[self alloc] initWithIcon:image title:title detailsTitle:details];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置frame
    self.leftIcon.frame = CGRectMake(0, 0, viewHeight, viewHeight);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.leftIcon.frame), 0, 150, viewHeight);
    
    CGFloat margin = 10;
    CGFloat arrowRightW = 30;
    CGFloat arrowRightX = viewWidth - arrowRightW - margin;
    self.arrowRight.frame = CGRectMake(arrowRightX, 0, arrowRightW, viewHeight);
    
    CGFloat detailsLabelX =CGRectGetMaxX(self.titleLabel.frame);
    CGFloat detailsLabelW = arrowRightX - detailsLabelX ;
    self.detailsLabel.frame = CGRectMake(detailsLabelX, 0, detailsLabelW, viewHeight);
}

-(void)setDetails:(NSString *)details
{
    _details = [details copy];
    self.detailsLabel.text = details;
}

@end

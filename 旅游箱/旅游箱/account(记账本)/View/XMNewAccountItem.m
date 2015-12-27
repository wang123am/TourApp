//
//  XMNewAccountItem.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/27.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMNewAccountItem.h"
#import "UIImage+XM.h"
#import "UIView+XM.h"

#define itemHeight self.frame.size.height
#define itemWidth self.frame.size.width
@interface XMNewAccountItem()
@property (nonatomic,assign)BOOL isShowArrow;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UIImageView *arrow;
@end

@implementation XMNewAccountItem
-(instancetype) initWithTitle:(NSString *)title details:(NSString *)details isShowArrow:(BOOL)arrow
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.isShowArrow = arrow;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        
        UILabel *detailsLabel = [[UILabel alloc] init];
        detailsLabel.text = details;
        detailsLabel.textAlignment = NSTextAlignmentRight;
        detailsLabel.textColor = [UIColor blackColor];
        detailsLabel.font = [UIFont systemFontOfSize:15];
        self.detailsLabel = detailsLabel;
        [self addSubview:detailsLabel];
        
        if (arrow) {
            UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage scaleToSize:[UIImage imageNamed:@"account_page_money_choice_arrow"] size:CGSizeMake(20, 20)]];
            arrow.contentMode = UIViewContentModeCenter;
            self.arrow = arrow;
            [self addSubview:arrow];
        }
        //点击条目时调用
        [self OnViewClickListener:self action:@selector(itemClickCallBack:)];
    }
    return self;
}

+(instancetype) itemWithTitle:(NSString *)title details:(NSString *)details isShowArrow:(BOOL)arrow
{
    return [[self alloc] initWithTitle:title details:details isShowArrow:arrow];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, itemHeight, itemHeight);
    
    CGFloat detailsLabelX = itemHeight +10;
    CGFloat arrowWidth = 20;
    self.detailsLabel.frame = CGRectMake(detailsLabelX, 0, itemWidth-detailsLabelX-arrowWidth, itemHeight);
    
    if (self.isShowArrow) {
        self.arrow.frame = CGRectMake(itemWidth-arrowWidth, 0, arrowWidth, itemHeight);
    }
}
-(void)itemClickCallBack:(int)viewTag
{
    if ([self.delegate respondsToSelector:@selector(itemClickCallBack:)]) {
        [self.delegate itemClickCallBack:self.type];
    }
}
@end

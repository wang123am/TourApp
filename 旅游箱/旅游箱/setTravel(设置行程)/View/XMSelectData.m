//
//  XMSelectData.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/3.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSelectData.h"
#define viewHeight self.frame.size.height
#define viewWidth self.frame.size.width
#define leftLabelW 100

@interface XMSelectData ()
@property (nonatomic,weak) UIImageView *leftImageView;
@property (nonatomic,weak) UILabel *leftLabel;
@property (nonatomic,weak) UIImageView *rightImageView;

@end

@implementation XMSelectData
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"travel_page_reset"]]];
    }
    return self;
}

-(instancetype)initWithLeftImg:(UIImage *)leftImg leftText:(NSString *)leftText rightText:(NSString *)rightText rightImg:(UIImage *)rightImg
{
    if(self = [super init])
    {
        //添加左边图片
        UIImageView *leftImageView = [self addImageView:leftImg];
        self.leftImageView = leftImageView;

        //添加左边文字
        UILabel *leftLabel = [self addLable:leftText];
        leftLabel.textColor = [UIColor grayColor];
        self.leftLabel = leftLabel;
        
        //添加右边图片
        UIImageView *rightImageView = [self addImageView:rightImg];
        self.rightImageView = rightImageView;
    
        //添加右边文字
        UILabel *rightLabel = [self addLable:rightText];
        self.rightLabel = rightLabel;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftImageView.frame = CGRectMake(0, 0, viewHeight, viewHeight);
    self.leftImageView.contentMode = UIViewContentModeCenter;
    
    self.leftLabel.frame = CGRectMake(viewHeight, 0, leftLabelW, viewHeight);
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    
    self.rightImageView.frame = CGRectMake(viewWidth - viewHeight, 0, viewHeight, viewHeight);
    self.rightImageView.contentMode = UIViewContentModeCenter;
    
    self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, viewWidth-2*viewHeight-leftLabelW, viewHeight);
    self.rightLabel.textAlignment = NSTextAlignmentRight;
}
/**
 *  添加一个imageView
 */
-(UIImageView *)addImageView:(UIImage *)img
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:imageView];
    return imageView;
}

/**
 *  添加一个Lable
 */

-(UILabel *)addLable:(NSString *)str
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = str;
    lable.font = [UIFont systemFontOfSize:15];
    [self addSubview:lable];
    return lable;
}
@end

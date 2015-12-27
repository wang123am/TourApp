//
//  XMTarBarButton.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/5.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTarBarButton.h"
#import "UILabel+XM.h"
@interface XMTarBarButton ()

@end

@implementation XMTarBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //添加左边按钮
        UILabel *leftLabel = [[UILabel alloc] init];
        [leftLabel OnViewClickListener:self action:@selector(leftLabelClick)];
        leftLabel.tag = 1;
        self.leftLabel = leftLabel;
        [self addLabel:leftLabel text:@"境内"];
        //添加右边按钮
        UILabel *rightLabel = [[UILabel alloc] init];
        [rightLabel OnViewClickListener:self action:@selector(rightLabelClick)];
        rightLabel.tag = 0;
        self.rightLabel = rightLabel;
        [self addLabel:rightLabel text:@"境外"];
        //添加引导条
        UIImageView *guideView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"citychoice_page_native_choice"]];
        self.guideView = guideView;
        [self addSubview:guideView];
    }
    return self;
}
+ (instancetype) barButton
{
    return [[self alloc] init];
}

/**
 *  往这个TarBarButton中添加境内境外两个按钮
 */
-(void) addLabel:(UILabel*)label text:(NSString*) text
{
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor whiteColor];
    label.text = text;
    [self addSubview:label];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat tabBarLabelW = self.frame.size.width * 0.5;
    CGFloat tabBarLabelH = self.frame.size.height - 10;
    self.leftLabel.frame = CGRectMake(0, 0, tabBarLabelW, tabBarLabelH);
    self.rightLabel.frame = CGRectMake(tabBarLabelW, 0, tabBarLabelW, tabBarLabelH);
    //计算引导条frame
    CGFloat guideViewHeight = 30;
    self.guideView.frame = CGRectMake(0, tabBarLabelH - 20, self.frame.size.width, guideViewHeight);
}
-(void)leftLabelClick
{
    if ([self.delegate respondsToSelector:@selector(tarBarButtonClick:guideView:)]){
        [self.delegate tarBarButtonClick:self.leftLabel guideView:self.guideView];
    }
}
-(void)rightLabelClick
{
    if ([self.delegate respondsToSelector:@selector(tarBarButtonClick:guideView:)]){
        [self.delegate tarBarButtonClick:self.rightLabel guideView:self.guideView];
    }
}
@end

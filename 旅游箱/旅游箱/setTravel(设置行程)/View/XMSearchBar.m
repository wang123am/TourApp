//
//  XMSearchBar.m
//  XiaoMingWeibo
//
//  Created by 梁亦明 on 15/2/8.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSearchBar.h"
#import "UIImage+XM.h"
@interface XMSearchBar ()
@property (nonatomic,weak) UIImageView *iconView;
@end

@implementation XMSearchBar
+(instancetype)searchBar
{
    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //设置背景图片
        self.background = [UIImage resizeImageWithNamed:@"citychoice_page_search_input_bg"];
        //添加搜索图片
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"citychoice_page_search_img"]];
        self.iconView = iconView;
        //设置图片居中
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        //添加右边删除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        //设置文本框字体大小
        self.font = [UIFont systemFontOfSize:14];
        //设置提示字体
        NSMutableDictionary *attrs= [NSMutableDictionary dictionary];
        //设置字体颜色
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"支持中英文搜索" attributes:attrs];
        
        //设置键盘右下角按钮
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置左边图标的frame
    self.iconView.frame = CGRectMake(0, 0, 50, self.frame.size.height);
}


@end

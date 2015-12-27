//
//  XMCityTitle.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMCityTitle.h"
#import "UIImage+XM.h"
@interface XMCityTitle()
@property (nonatomic,weak) UILabel *label;
@end
@implementation XMCityTitle
-(instancetype) initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        [self setImage: [UIImage resizeImageWithNamed:@"citychoice_page_listview_group_bg"]];
        //添加文字
        UILabel *label = [[UILabel alloc] init];
        self.label = label;
        label.textColor = [UIColor redColor];
        label.text = title;
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = CGRectMake(10, 0, self.frame.size.width, self.frame.size.height);
}
+(instancetype) titleWithName:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}
@end

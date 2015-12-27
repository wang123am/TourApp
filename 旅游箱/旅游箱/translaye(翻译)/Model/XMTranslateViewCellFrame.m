//
//  XMTranslateViewCellFrame.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/22.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTranslateViewCellFrame.h"
#import "XMTranslateModel.h"

#define fontSize [UIFont systemFontOfSize:15]
@implementation XMTranslateViewCellFrame


-(void)setModel:(XMTranslateModel *)model
{
    _model = model;
    CGFloat margin = 20;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat translateViewFrameW = screenSize.width-2*margin;
    
    //计算要翻译文段frame
    CGFloat padding = 10;
    CGFloat fromLabelFrameW = translateViewFrameW - margin;
    CGSize fromTextSize =  [self sizeWithString:model.src font:fontSize maxSize:CGSizeMake(fromLabelFrameW, MAXFLOAT)];
    _fromLabelFrame = (CGRect){{margin, padding},fromTextSize};
    
    //计算翻译后文段frame
    CGSize toTextSize =  [self sizeWithString:model.dst font:fontSize maxSize:CGSizeMake(fromLabelFrameW, MAXFLOAT)];
    _toLabelFrame = (CGRect){{margin, CGRectGetMaxY(_fromLabelFrame) + padding}, toTextSize};
    
    _translateViewFrame = CGRectMake(margin, 0.5*margin, translateViewFrameW, CGRectGetMaxY(_toLabelFrame)+padding);
    //计算cell的高度
    _cellHeight = CGRectGetMaxY(_translateViewFrame) + padding;
}

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}
@end

//
//  XMTranslateViewCellFrame.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/22.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XMTranslateModel;
@interface XMTranslateViewCellFrame : NSObject

/**
 *  内容的view
 */
@property (nonatomic,assign)CGRect translateViewFrame;
/**
 *  要翻译的文段
 */
@property (nonatomic,assign,readonly)CGRect fromLabelFrame;

/**
 *  翻译后的文段
 */
@property (nonatomic,assign,readonly)CGRect toLabelFrame;

/**
 *  计算cell的高度
 */
@property (nonatomic,assign,readonly)CGFloat cellHeight;

/**
 *  数据模型
 */
@property (nonatomic,strong) XMTranslateModel *model;
@end

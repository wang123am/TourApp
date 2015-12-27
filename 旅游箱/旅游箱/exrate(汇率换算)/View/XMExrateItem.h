//
//  XMExrateItem.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/23.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMExrateItemDelegate <NSObject>
@optional
-(void)exrateButtonClick:(UIButton *)exrateButton;
@end

@interface XMExrateItem : UIView
/**
 *  那种银币标签
 */
@property (nonatomic,weak) UIButton *exrateButton;
/**
 *  分割线
 */
@property (nonatomic,weak) UIImageView *verView;
/**
 *  金额
 */
@property (nonatomic,weak) UILabel *numberLabel;

@property (nonatomic,weak) id <XMExrateItemDelegate> delegate;
@end

//
//  XMNewAccountGridItem.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/26.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMNewAccountGridItem;
@protocol XMNewAccountGridItemDelegate <NSObject>
@optional
-(void)gridItemButtonClick:(XMNewAccountGridItem *)selectItem;
@end

@interface XMNewAccountGridItem : UIView
@property (nonatomic,weak) UIButton *imgButton;
@property (nonatomic,weak) UILabel *nameLabel;
-(instancetype) initWithItemName:(NSString *)itemName nomImg:(UIImage *) nomImg selectImg:(UIImage *)selectImg;
+(instancetype) gridItemWithName:(NSString *)itemName nomImg:(UIImage *) nomImg selectImg:(UIImage *)selectImg;
@property (nonatomic,weak) id <XMNewAccountGridItemDelegate> delegate;
@end

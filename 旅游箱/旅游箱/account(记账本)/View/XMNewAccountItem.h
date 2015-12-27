//
//  XMNewAccountItem.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/27.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    moneyItemTag,
    exrateItemTag,
    dateItemTag,
    commentsItemTag
}XMNewAccountItemTag;

@protocol XMNewAccountItemDelegate <NSObject>

@optional
-(void)itemClickCallBack:(XMNewAccountItemTag)type;
@end
@interface XMNewAccountItem : UIView
@property (nonatomic,weak) UILabel *detailsLabel;
-(instancetype) initWithTitle:(NSString *)title details:(NSString *)details isShowArrow:(BOOL)arrow;
+(instancetype) itemWithTitle:(NSString *)title details:(NSString *)details isShowArrow:(BOOL)arrow;
@property (nonatomic,weak) id <XMNewAccountItemDelegate> delegate;
@property (nonatomic,assign)XMNewAccountItemTag type;
@end

//
//  XMTravelassistantTouristMoneyItem.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/9.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    moneyItemType = 0,
    exrateItemType
}TickeyItemType;

@protocol XMTravelassistantTouristTicketItemDelegate <NSObject>

@optional
-(void)travelassistantTouristTicketItemClick:(TickeyItemType)itemType;
@end

@interface XMTravelassistantTouristTicketItem : UIView
/** 右边label */
@property (nonatomic,weak) UILabel *rightLabel;
@property (nonatomic,assign)TickeyItemType itemType;

-(instancetype) initWithTitle:(NSString *)title rightLabelText:(NSString *)rightText;
+(instancetype) ticketItemWithTitle:(NSString *)title rightLabelText:(NSString *)rightText;
@end

//
//  XMOutSizeCityCell.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLeaves.h"
@interface XMOutSizeCityCell : UITableViewCell
@property (nonatomic,strong) XMLeaves *leaves;
+(instancetype) cellWithTableView:(UITableView*)table;
@end

//
//  XMTravelassitstantTouristCell.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/11.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMTravelassistantTouristModel;
@interface XMTravelassistantTouristCell : UITableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) XMTravelassistantTouristModel *model;
@property (nonatomic,assign) long row;
@end

//
//  XMTravelassistantNoteCell.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMTravelassistantNoteModel;
@interface XMTravelassistantNoteCell : UITableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView;
/** 设置内容*/
@property (nonatomic,strong) XMTravelassistantNoteModel * model;
@end

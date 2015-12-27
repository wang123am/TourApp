//
//  XMSettingTableViewCell.h
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMSettingListModel;
@interface XMSettingTableViewCell : UITableViewCell
@property (nonatomic,strong) XMSettingListModel *model;
+(instancetype) cellWithTableView:(UITableView *)tableView;
@end

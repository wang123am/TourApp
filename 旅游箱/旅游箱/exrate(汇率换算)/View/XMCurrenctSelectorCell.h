//
//  XMCurrenctSelectorCell.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/25.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMExrateModel.h"
@interface XMCurrenctSelectorCell : UITableViewCell
-(instancetype) initWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+(instancetype) cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@property (nonatomic,strong) XMExrateModel *model;
@end

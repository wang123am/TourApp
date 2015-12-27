//
//  XMLanguageSelectCellTableViewCell.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/21.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLanguageModel.h"
@interface XMLanguageSelectCell : UITableViewCell
+(instancetype) cellWithTableViewCell:(UITableView *)tableView;
@property (nonatomic,strong) XMLanguageModel *model;
@end

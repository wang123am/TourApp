//
//  XMAccountTableViewCell.h
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMAccountModel;
@interface XMAccountTableViewCell : UITableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,strong) XMAccountModel *tableViewModel;
@end

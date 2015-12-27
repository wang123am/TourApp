//
//  XMOutSizeCityCell.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMOutSizeCityCell.h"

@implementation XMOutSizeCityCell
+(UITableViewCell*) cellWithTableView:(UITableView*)tableView
{
    static NSString *cityId = @"cityId";
    //1.先去缓存池中查找是否有满足条件的Cell
    XMOutSizeCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cityId];
    if (cell == nil) {
        cell = [[XMOutSizeCityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cityId];
    }
    return cell;
}

-(void)setLeaves:(XMLeaves *)leaves
{
    _leaves = leaves;
    self.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",_leaves.cityName,_leaves.countryName];
    if (_leaves.isSelect) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}
@end

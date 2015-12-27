//
//  XMCurrenctSelectorCell.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/25.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMCurrenctSelectorCell.h"

@implementation XMCurrenctSelectorCell
-(instancetype) initWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString *exrateID = @"exrateId";
    XMCurrenctSelectorCell *cell = [tableView dequeueReusableCellWithIdentifier:exrateID];
    if (cell == nil) {
        cell = [[XMCurrenctSelectorCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:exrateID];
    }else {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    return cell;
}

+(instancetype) cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    return [[self alloc] initWithTableView:tableView indexPath:indexPath];
}

/**
 *  传递模型时调用
 */
-(void)setModel:(XMExrateModel *)model
{
    _model = model;
    if (_model.isSelect) {
        self.textLabel.textColor = [UIColor orangeColor];
        self.detailTextLabel.textColor = [UIColor orangeColor];
    }
    self.textLabel.text = model.coin;
    self.detailTextLabel.text = model.code;
}

@end

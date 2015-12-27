//
//  XMTranslateViewCell.h
//  XMTour
//
//  Created by 梁亦明 on 15/3/21.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMTranslateModel.h"
#import "XMTranslateViewCellFrame.h"

@interface XMTranslateViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView;
@property (nonatomic,strong) XMTranslateViewCellFrame *frameModel;
@property (nonatomic,assign) CGFloat cellHeight;

@end

//
//  XMSettingTableViewCell.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/1.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSettingTableViewCell.h"
#import "XMSettingListModel.h"
#import "UIImage+XM.h"
#define viewHeight 50
#define viewWidth 375
@interface XMSettingTableViewCell()
/** 图标*/
@property (nonatomic,weak) UIImageView *leftIcon;
/** 文字*/
@property (nonatomic,weak) UILabel *titleLabel;
/** 右边指示图片*/
@property (nonatomic,weak) UIImageView *arrowRight;
/** 电话*/
@property (nonatomic,weak) UILabel *phoneLabel;
/** 分割线*/
@property (nonatomic,weak) UIView *separatorView;
@end

@implementation XMSettingTableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *settingCellId = @"settingCellid";
    XMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellId];
    if (!cell)
        cell = [[XMSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCellId];
    return cell;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        //添加图标
        UIImageView *leftIcon = [[UIImageView alloc] init];
        leftIcon.contentMode = UIViewContentModeCenter;
        self.leftIcon = leftIcon;
        [self.contentView addSubview:leftIcon];
        
        //添加文字
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.alpha = 0.7;
        self.titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        
        UILabel *phoneLabel = [[UILabel alloc] init];
        phoneLabel.text = @"110";
        phoneLabel.font = [UIFont systemFontOfSize:11];
        phoneLabel.textColor = [UIColor grayColor];
        self.phoneLabel = phoneLabel;
        [self.contentView addSubview:phoneLabel];
        
        UIImageView *arrowRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_money_choice_arrow"]];
        arrowRight.contentMode = UIViewContentModeCenter;
        self.arrowRight = arrowRight;
        [self.contentView addSubview:arrowRight];
        
        UIView *separatorView = [[UIView alloc] init];
        separatorView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        self.separatorView = separatorView;
        [self.contentView addSubview:separatorView];
    }
    return  self;
   
}

-(void)setModel:(XMSettingListModel *)model
{
   
    _model = model;

    //设置frame
    self.leftIcon.frame = CGRectMake(0, 0, viewHeight, viewHeight);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.leftIcon.frame), 0, 150, viewHeight);
    CGFloat margin = 10;
   
    if (model.settingListType == XMSettingListSwitch) {
        [self.phoneLabel removeFromSuperview];
        [self.arrowRight setImage:[UIImage imageNamed:@"setting_page_notify_bt_up"]];
        CGFloat arrowRightW = 80;
        CGFloat arrowRightX = viewWidth - arrowRightW - margin;
        self.arrowRight.frame = CGRectMake(arrowRightX, 0, arrowRightW, viewHeight);
    } else if (model.settingListType == XMSettingListPhone) {
        CGFloat phoneW = 50;
        CGFloat arrowRightW = 30;
        CGFloat arrowRightX = viewWidth - arrowRightW - margin;
        self.arrowRight.frame = CGRectMake(arrowRightX, 0, arrowRightW, viewHeight);
        self.phoneLabel.frame = CGRectMake(arrowRightX - phoneW, 0, phoneW, viewHeight);
    } else {
        CGFloat arrowRightW = 30;
        CGFloat arrowRightX = viewWidth - arrowRightW - margin;
        self.arrowRight.frame = CGRectMake(arrowRightX, 0, arrowRightW, viewHeight);
    }
    CGFloat separatorViewX = CGRectGetMaxX(self.leftIcon.frame);
    CGFloat separatorViewH = 2;
    self.separatorView.frame = CGRectMake(separatorViewX, viewHeight, viewWidth-separatorViewX, separatorViewH);
    //设置内容
    [self.leftIcon setImage:[UIImage scaleToSize:[UIImage imageNamed:model.icon] size:CGSizeMake(30, 30)]];
    self.titleLabel.text = model.text;
}
@end

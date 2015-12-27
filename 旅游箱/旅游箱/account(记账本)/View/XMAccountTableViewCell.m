//
//  XMAccountTableViewCell.m
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMAccountTableViewCell.h"
#import "XMAccountModel.h"

#define cellHeight 60
#define cellWidth 335
@interface XMAccountTableViewCell()
@property (nonatomic,weak) UIImageView *typeImg;
@property (nonatomic,weak) UILabel *typeName;
@property (nonatomic,weak) UILabel *commentsText;
@property (nonatomic,weak) UILabel *moneyLabel;
@property (nonatomic,weak) UIImageView *photo;
@end
@implementation XMAccountTableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *accountId = @"accountid";
    XMAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:accountId];
    if (!cell)
        cell = [[XMAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountId];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *typeImg = [[UIImageView alloc] init];
        self.typeImg = typeImg;
        typeImg.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:typeImg];
        
        UILabel *typeName = [[UILabel alloc] init];
        self.typeName = typeName;
        typeName.textAlignment = NSTextAlignmentNatural;
        typeName.font = [UIFont systemFontOfSize:13];
        typeName.textColor = [UIColor grayColor];
        [self.contentView addSubview:typeName];
        
        UILabel *commentsText = [[UILabel alloc] init];
        self.commentsText = commentsText;
        commentsText.numberOfLines = 0;
        commentsText.font = [UIFont systemFontOfSize:11];
        commentsText.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:commentsText];
        
        UILabel *moneyLabel = [[UILabel alloc] init];
        self.moneyLabel = moneyLabel;
        moneyLabel.textColor = [UIColor blackColor];
        moneyLabel.numberOfLines = 0;
        moneyLabel.font = [UIFont systemFontOfSize:12];
        moneyLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:moneyLabel];
        
        UIImageView *photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_pic_mark_img"]];
        self.photo = photo;
        photo.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:photo];
        
        UIImageView *separateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, cellHeight-1, cellWidth, 1)];
        separateView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        [self.contentView addSubview:separateView];
    }
    return self;
}

-(void)setTableViewModel:(XMAccountModel *)tableViewModel
{
    _tableViewModel = tableViewModel;
    //1.设置frame
    CGFloat margin = 10;
    //设置类型图片
    self.typeImg.frame = CGRectMake(0, 0, cellHeight, cellHeight);
    //设置类型
    CGFloat typeNameW = 40;
    //判断有无备注
    if (self.tableViewModel.isHageComments) {
        self.typeName.frame = CGRectMake(cellHeight, margin, typeNameW, cellHeight * 0.5 - margin);
        self.commentsText.frame = CGRectMake(cellHeight, cellHeight*0.5, 160, cellHeight*0.5);
        //判断有无图片
        if (self.tableViewModel.isHavePhoto) {
            self.photo.frame = CGRectMake(CGRectGetMaxX(self.typeName.frame), 0.5*margin, cellHeight*0.5, cellHeight*0.5);
        } else {
            [self.photo removeFromSuperview];
        }
    } else {
        self.typeName.frame = CGRectMake(cellHeight, 0, typeNameW, cellHeight);
        //判断有无图片
        if (self.tableViewModel.isHavePhoto) {
            self.photo.frame = CGRectMake(CGRectGetMaxX(self.typeName.frame) + 5, 0, cellHeight, cellHeight);
            self.photo.contentMode = UIViewContentModeLeft;
        } else {
            [self.photo removeFromSuperview];
        }
    }
    
    //设置金额
    self.moneyLabel.frame = CGRectMake(cellWidth*0.7, 0, cellWidth*0.3-margin, cellHeight);
    
    //2.设置内容
    switch (tableViewModel.consumeType) {
        case eatType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_eat_mark_normal"]];
            break;
        case trafficType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_transport_mark_normal"]];
            break;
        case shoppingType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_shopping_mark_normal"]];
            break;
        case amuseType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_amuse_mark_normal"]];
            break;
        case facialType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_snack_mark_normal"]];
            break;
        case hotelType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_hotel_mark_normal"]];
            break;
        case ticketType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_ticket_mark_normal"]];
            break;
        case hospitalType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_medi_mark_normal"]];
            break;
        case insuranceType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_insure_mark_normal"]];
            break;
        case otherType:
            [self.typeImg setImage:[UIImage imageNamed:@"account_page_gener_mark_normal"]];
            break;
    }
    self.typeName.text = tableViewModel.type;
    self.commentsText.text = tableViewModel.comments;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@ %@",tableViewModel.code,tableViewModel.money];
}

@end

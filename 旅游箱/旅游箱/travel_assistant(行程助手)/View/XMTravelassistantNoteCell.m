//
//  XMTravelassistantNoteCell.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantNoteCell.h"
#import "UIImage+XM.h"
#import "XMTravelassistantNoteModel.h"

#define viewHeight self.frame.size.height
#define viewWidth 335
#define topViewHeight 5
#define buttomViewHeight 8
#define viewIntervalHeight 7

@interface XMTravelassistantNoteCell ()
/** 顶部图片*/
@property (nonatomic,weak) UIImageView *topView;
/** 显示内容*/
@property (nonatomic,weak) UIView *centerView;
/** 显示内容uilabel*/
@property (nonatomic,weak) UILabel *contentLabel;
/** 显示时间label*/
@property (nonatomic,weak) UILabel *timeLabel;
/** 底部图片*/
@property (nonatomic,weak) UIImageView *buttomView;
/** cell间隔*/
@property (nonatomic,weak) UIView *intervalView;
@end

@implementation XMTravelassistantNoteCell
+(instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString * noteId = @"noteId";
    XMTravelassistantNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:noteId];
    if (!cell)
        cell = [[XMTravelassistantNoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noteId];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        //取消选中颜色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *topView = [[UIImageView alloc] initWithImage:[UIImage scaleToSize:[UIImage imageNamed:@"account_page_color_line_no_shaow"] size:CGSizeMake(viewWidth, topViewHeight)]];
        self.topView = topView;
        [self.contentView addSubview:topView];
        
        UIView *centerView = [[UIView alloc] init];
        centerView.backgroundColor = [UIColor whiteColor];
        self.centerView = centerView;
        [self.contentView addSubview:centerView];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        self.contentLabel = contentLabel;
        contentLabel.font = [UIFont systemFontOfSize:13];
        contentLabel.textColor = [UIColor blackColor];
        [centerView addSubview:contentLabel];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.textColor = [UIColor grayColor];
        self.timeLabel = timeLabel;
        [centerView addSubview:timeLabel];
        
        UIImageView *buttomView = [[UIImageView alloc] initWithImage:[UIImage scaleToSize:[UIImage imageNamed:@"account_page_griditem_bottom_border"] size:CGSizeMake(viewWidth, buttomViewHeight)]];
        self.buttomView = buttomView;
        [self.contentView addSubview:buttomView];
        
        UIView *intervalView = [[UIView alloc] init];
        self.intervalView = intervalView;
        [self.contentView addSubview:intervalView];
    }
    return self;
}

/**
 *  设置内容
 */
-(void)setModel:(XMTravelassistantNoteModel *)model
{
    _model = model;
    //设置frame;
    self.topView.frame = CGRectMake(0, 0, viewWidth, topViewHeight);
    self.centerView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), viewWidth, 50);
    self.contentLabel.frame = CGRectMake(10, 0, viewWidth - 10, 40);
    self.timeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame), viewWidth - 10, 10);
    self.buttomView.frame = CGRectMake(0, CGRectGetMaxY(self.centerView.frame), viewWidth, buttomViewHeight);
    self.intervalView.frame = CGRectMake(0, CGRectGetMaxY(self.buttomView.frame), viewWidth, viewIntervalHeight);
    //设置数据
    self.contentLabel.text = model.noteText;
    self.timeLabel.text = model.noteTime;
}

@end

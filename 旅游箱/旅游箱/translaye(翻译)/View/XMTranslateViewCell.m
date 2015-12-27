//
//  XMTranslateViewCell.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/21.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTranslateViewCell.h"
#import "UIImage+XM.h"

@interface XMTranslateViewCell()
@property (nonatomic,weak) UIView *translateView;
@property (nonatomic,weak) UILabel *fromLabel;
@property (nonatomic,weak) UILabel *toLabel;
@end
@implementation XMTranslateViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString *translateId = @"translateID";
    XMTranslateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:translateId];
    if (cell == nil) {
        cell = [[XMTranslateViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:translateId];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *translateView = [[UIView alloc] init];
        translateView.backgroundColor = [UIColor whiteColor];
        self.translateView = translateView;
        [self.contentView addSubview:translateView];

        //要翻译的文段
        UILabel *fromLabel = [[UILabel alloc] init];
        fromLabel.font = [UIFont systemFontOfSize:15];
        [fromLabel setNumberOfLines:0];
        fromLabel.textColor = [UIColor grayColor];
        self.fromLabel = fromLabel;
        [self.translateView addSubview:fromLabel];
        
        //翻译后的文段
        UILabel *toLabel = [[UILabel alloc] init];
        toLabel.font = [UIFont systemFontOfSize:15];
        [toLabel setNumberOfLines:0];
        toLabel.textColor = [UIColor blackColor];
        self.toLabel = toLabel;
        [self.translateView addSubview:toLabel];
        
        //清除背景色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setFrameModel:(XMTranslateViewCellFrame *)frameModel
{
    _frameModel = frameModel;
    XMTranslateModel *model = frameModel.model;
    //设置数据
    self.fromLabel.text = model.src;
    self.toLabel.text = model.dst;
    //设置frame
    self.translateView.frame = frameModel.translateViewFrame;
    self.fromLabel.frame = frameModel.fromLabelFrame;
    self.toLabel.frame = frameModel.toLabelFrame;
}

@end

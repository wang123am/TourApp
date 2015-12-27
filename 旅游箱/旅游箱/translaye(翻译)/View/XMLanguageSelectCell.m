//
//  XMLanguageSelectCellTableViewCell.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/21.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMLanguageSelectCell.h"

@interface XMLanguageSelectCell ()
@property (weak, nonatomic) IBOutlet UIImageView *languageView;
@property (weak, nonatomic) IBOutlet UILabel *languageName;
@property (weak, nonatomic) IBOutlet UIImageView *selectorView;

@end
@implementation XMLanguageSelectCell

+(instancetype)cellWithTableViewCell:(UITableView *)tableView
{
    static NSString *languageId = @"languageid";
    XMLanguageSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:languageId];
    if (cell == nil)
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XMLanguageSelectCell" owner:nil options:nil]lastObject];
    return cell;
}

-(void)setModel:(XMLanguageModel *)model
{
    _model = model;
    self.languageView.image = [UIImage imageNamed:model.icon];
    self.languageName.text = model.languageName;
    self.selectorView.image = model.isSelect?[UIImage imageNamed:@"citychoice_page_selected_mark"]:nil;
}

@end

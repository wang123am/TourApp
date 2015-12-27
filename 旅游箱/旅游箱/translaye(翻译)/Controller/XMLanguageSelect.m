//
//  XMLanguageSelect.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMLanguageSelect.h"
#import "XMAppStart.h"
#import "XMTranslateDb.h"
#import "XMLanguageModel.h"
#import "XMLanguageSelectCell.h"

@interface XMLanguageSelect ()
/** 国家信息集合*/
@property (nonatomic,strong) NSMutableArray *languageArray;
@end

@implementation XMLanguageSelect


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择语种";
    self.tableView.rowHeight = 80;
    self.tableView.showsVerticalScrollIndicator = NO;
    //1.加载信息
    XMTranslateDb *db = [[XMTranslateDb alloc] init];
    self.languageArray = [db selectAllLanguageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.languageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    XMLanguageSelectCell*cell = [XMLanguageSelectCell cellWithTableViewCell:tableView];
    XMLanguageModel *model = self.languageArray[indexPath.row];
    if ([self.selectLanguage isEqualToString:model.languageName]) {
        model.select = YES;
    }
    //传递模型
    cell.model = model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMLanguageModel *model = self.languageArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectLanguageCallBack:)]) {
        [self.delegate selectLanguageCallBack:model.languageName];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end

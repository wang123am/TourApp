//
//  XMCurrencySelector.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/24.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMCurrencySelector.h"
#import "XMExrateDb.h"
#import "XMExrateModel.h"
#import "XMCurrenctSelectorCell.h"

@interface XMCurrencySelector ()
@property (nonatomic,strong) NSArray *currencyArray;
@property (nonatomic,strong) XMExrateDb *db;
@end

@implementation XMCurrencySelector

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"币种选择";
    XMExrateDb *db = [[XMExrateDb alloc] init];
    self.db = db;
    self.currencyArray = [db selectAllExrateData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.currencyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    XMCurrenctSelectorCell *cell = [XMCurrenctSelectorCell cellWithTableView:tableView indexPath:indexPath];
    //传递模型
    XMExrateModel *model = self.currencyArray[indexPath.row];
    if ([self.currentExrate isEqualToString:model.code]) {
        model.select = YES;
    }
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMExrateModel *model = self.currencyArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(currencySelectorCallBack:)]) {
        [self.delegate currencySelectorCallBack:model.code];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

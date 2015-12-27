//
//  XMLetterCity.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMLetterCity.h"
#import "XMSetTravelDB.h"

@interface XMLetterCity() <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *cityArray;
@end

@implementation XMLetterCity
-(NSMutableArray *)cityArray
{
    if (_cityArray == nil) {
        XMSetTravelDB *db = [[XMSetTravelDB alloc] init];
        self.cityArray = [db selectCityWithletter:self.navTitle];
    }
    return _cityArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 40;
    self.navigationItem.title = [NSString stringWithFormat:@"%@%@",self.navTitle,@"开头的城市"];
}

#pragma mark --UITableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cityID = @"cityID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cityID];
    }
    cell.textLabel.text = self.cityArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取点击行的cell
    UITableViewCell *cell   = [tableView cellForRowAtIndexPath:indexPath];
    // 取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //回传参数
    if ([self.delegate respondsToSelector:@selector(letterCityCallBackWithCityName:)]) {
        [self.delegate letterCityCallBackWithCityName:cell.textLabel.text];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

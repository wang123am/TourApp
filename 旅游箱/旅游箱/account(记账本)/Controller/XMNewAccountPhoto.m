//
//  XMNewAccountPhoto.m
//  旅游箱
//
//  Created by 梁亦明 on 15/3/29.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMNewAccountPhoto.h"
#import "UIBarButtonItem+XM.h"
@interface XMNewAccountPhoto ()<UIAlertViewDelegate>

@end

@implementation XMNewAccountPhoto

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"account_page_calc_delete_up"] selectorImg:[UIImage imageNamed:@"account_page_calc_delete_down"] target:self action:@selector(rightBarButtonClick)];
    self.navigationItem.title = @"图片浏览";
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    //添加一个uiimageView用于显示图片
    UIImageView *photoView = [[UIImageView alloc] initWithImage:self.photoImg];
    photoView.frame = self.view.frame;
    photoView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:photoView];
}

-(void)rightBarButtonClick
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定删除该图片吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        //点击了删除按钮
        if ([self.delegate respondsToSelector:@selector(deletePhotoCallBack)]) {
            [self.delegate deletePhotoCallBack];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end

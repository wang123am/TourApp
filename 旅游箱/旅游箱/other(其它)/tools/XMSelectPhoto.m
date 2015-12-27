//
//  XMSelectPhoto.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/10.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMSelectPhoto.h"
#import <UIKit/UIKit.h>
@implementation XMSelectPhoto
/**
 *  打开相册
 */
+(void)openLocalPhotoWithTager:(id)tager
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = tager;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [tager presentViewController:picker animated:YES completion:nil];
}

/**
 *  打开照相机
 */
+(void)takePhotoWithTager:(id)tager
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = tager;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [tager presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"模拟器不能拍照哟");
    }
}
@end

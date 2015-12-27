//
//  XMTravelassistantTouristItem.m
//  旅游箱
//
//  Created by 梁亦明 on 15/4/8.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTravelassistantTouristItem.h"

#define leftLabelWidth 80
#define textFieldWidth self.frame.size.width - leftLabelWidth - 10
#define textFieldFontSize [UIFont systemFontOfSize:12]

@interface XMTravelassistantTouristItem ()<UITextFieldDelegate>
/** 左边标签*/
@property (nonatomic,weak) UILabel *leftLabel;
/** 右边view*/
@property (nonatomic,weak) UIView *rightView;
@end

@implementation XMTravelassistantTouristItem

-(instancetype) initWithTitle:(NSString *) title
{
    if (self = [super init]) {
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.backgroundColor = [UIColor whiteColor];
        leftLabel.text = title;
        leftLabel.textColor = [UIColor grayColor];
        leftLabel.font = [UIFont systemFontOfSize:13];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel = leftLabel;
        [self addSubview:leftLabel];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.font = textFieldFontSize;
        textField.textAlignment = NSTextAlignmentRight;
        textField.backgroundColor = [UIColor whiteColor];
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        self.TextField = textField;
        [self addSubview:textField];
        
        UIView *rightView = [[UIView alloc] init];
        rightView.backgroundColor = [UIColor whiteColor];
        self.rightView = rightView;
        [self addSubview:rightView];
    }
    return self;
}

+(instancetype) touristItemWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewHeight = self.frame.size.height;
    self.leftLabel.frame = CGRectMake(0, 0, leftLabelWidth, viewHeight);
    self.textField.frame = CGRectMake(leftLabelWidth, 0, textFieldWidth, viewHeight);
    self.rightView.frame = CGRectMake(CGRectGetMaxX(self.textField.frame), 0, 10, viewHeight);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(void)closeKeyboard
{
    [self.textField resignFirstResponder];
}
@end

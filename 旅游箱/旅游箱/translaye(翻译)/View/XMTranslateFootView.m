//
//  XMTranslateFootView.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/20.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTranslateFootView.h"
@interface XMTranslateFootView() <UITextFieldDelegate>

@end

@implementation XMTranslateFootView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
        UITextField *textField = [[UITextField alloc] init];
        textField.delegate = self;
        textField.backgroundColor = [UIColor whiteColor];
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.font = [UIFont systemFontOfSize:14];
        textField.returnKeyType = UIReturnKeyDone;
        [textField addTarget:self action:@selector(textFieldChanged:forEvent:) forControlEvents:UIControlEventEditingChanged];
        //设置提示字体
        NSMutableDictionary *attrs= [NSMutableDictionary dictionary];
        //设置字体颜色
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入要翻译的文字" attributes:attrs];
        //设置光标左边间距
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField = textField;
        [self addSubview:textField];
        
        UIButton *sendButton = [[UIButton alloc] init];
        [sendButton addTarget:self action:@selector(onSendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setBackgroundImage:[UIImage imageNamed:@"translate_page_bottom_send_btn_gray"] forState:UIControlStateDisabled];
        [sendButton setBackgroundImage:[UIImage imageNamed:@"translate_page_bottom_send_btn_pressed"] forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
        self.sendButton = sendButton;
        sendButton.enabled = NO;
        [self addSubview:sendButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewHeight = self.frame.size.height;
    CGFloat viewWidth = self.frame.size.width;
    CGFloat margin = 10;
    
    CGFloat textFieldW = 300;
    self.textField.frame = CGRectMake(margin, margin, textFieldW, viewHeight - 2*margin);
    
    CGFloat sendButtonX = CGRectGetMaxX(self.textField.frame)+margin;
    self.sendButton.frame = CGRectMake(sendButtonX, margin, viewWidth-margin-sendButtonX, viewHeight-2*margin);
}

/**
 *  点击返回done键
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
/**
 *  点击文本框删除键
 */
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.sendButton.enabled = NO;
    textField.text = nil;
    return NO;
}

- (void) textFieldChanged:(UITextField*)textField forEvent:(UIEvent *)event
{
    self.sendButton.enabled = ![textField.text isEqualToString:@""];
}

/**
 *  点击发送
 */
-(void)onSendButtonClick
{
    if ([self.delegate respondsToSelector:@selector(sendButtonClick:)]) {
        [self.delegate sendButtonClick:[self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
}

@end

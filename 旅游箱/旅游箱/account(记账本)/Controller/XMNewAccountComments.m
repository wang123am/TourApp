//
//  XMNewAccountCommentsViewController.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/28.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMNewAccountComments.h"
#import "UIBarButtonItem+XM.h"

@interface XMNewAccountComments ()<UITextViewDelegate>
@property (nonatomic,weak) UITextView *textView;
@end

@implementation XMNewAccountComments

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    self.navigationItem.title = self.controllerTitle;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"account_page_title_right_finish"] selectorImg:[UIImage imageNamed:@"account_page_title_right_finish_press"] target:self action:@selector(rightTitleClick)];
    //添加文本框
    CGFloat margin = 10;
    CGFloat textViewH = 0;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(margin,textViewH,self.view.frame.size.width-2*margin, self.view.frame.size.height-textViewH-margin)];
    self.textView = textView;
    textView.text = self.text;
    textView.delegate = self;
    textView.backgroundColor = [UIColor whiteColor];
    textView.showsVerticalScrollIndicator = NO;
    textView.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:textView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}


-(void)rightTitleClick
{
    [self.textView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(commentsCallBackWithText:)]) {
        [self.delegate commentsCallBackWithText:[self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end

//
//  XMTranslateRootControllerViewController.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/16.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMTranslateRootController.h"
#import "XMTranslateHeaderView.h"
#import "XMTranslateFootView.h"
#import "XMLanguageSelect.h"
#import "XMTranslateViewCell.h"
#import "XMTranslateDb.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "XMBaiduAccount.h"
#import "XMTranslateModel.h"
#import "XMSetTravelTool.h"

#define viewWidth self.view.frame.size.width
#define viewHeight self.view.frame.size.height
#define headerY 70
#define footViewHeight 50

@interface XMTranslateRootController ()<UITableViewDataSource,UITableViewDelegate,XMTranslateHeaderViewDelegate,XMTranslateFootViewDelegate,XMLanguageSelectDelegate>
/** 头部界面*/
@property (nonatomic,weak) XMTranslateHeaderView *headerView;
/** 中间界面*/
@property (nonatomic,weak) UITableView *centerView;
/** 脚步界面*/
@property (nonatomic,weak) XMTranslateFootView *footView;
/** 记录当前选择语言的按钮*/
@property (nonatomic,weak) UIButton *languageButton;
/** 保存翻译数据的数组*/
@property (nonatomic,strong) NSMutableArray *translateArray;
/** 数据库*/
@property (nonatomic,strong) XMTranslateDb *db;
@end

@implementation XMTranslateRootController

-(NSMutableArray *)translateArray
{
    if (_translateArray == nil) self.translateArray = [self.db selectAllTranslateData];
    return _translateArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //获取数据库中翻译的数据
    XMTranslateDb *db = [[XMTranslateDb alloc] init];
    self.db = db;
    
    self.navigationItem.title = @"实时翻译";
    //1.设置头部
    [self addHeaderView];
    [self addCenterView];
    [self addFootView];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChang:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)addHeaderView
{
    XMTranslateHeaderView *headerView = [[XMTranslateHeaderView alloc] initWithFrame:CGRectMake(0, headerY, viewWidth, footViewHeight)];
    headerView.delegate = self;
    self.headerView = headerView;
    [self.view addSubview:headerView];
}
-(void)addCenterView
{
    UITableView *centerView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), viewWidth, viewHeight - 2*footViewHeight-headerY)];
    centerView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    centerView.showsVerticalScrollIndicator = NO;
    centerView.separatorStyle = UITableViewCellSeparatorStyleNone;
    centerView.allowsSelection = NO;
    centerView.delegate = self;
    centerView.dataSource = self;
    self.centerView = centerView;
    [self.view addSubview:centerView];
}
-(void)addFootView
{
    XMTranslateFootView *footView = [[XMTranslateFootView alloc] initWithFrame:CGRectMake(0, viewHeight - footViewHeight, viewWidth, footViewHeight)];
    footView.delegate = self;
    self.footView = footView;
    [self.view addSubview:footView];
}
#pragma mark - 键盘出现消失时调用
-(void)keyboardWillChang:(NSNotification *)aNotification
{
    self.view.window.backgroundColor = self.centerView.backgroundColor;
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyY = keyboardRect.origin.y;
    //获取键盘动画时间
    float animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //改变控件frame
    [UIView animateWithDuration:animationDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyY - viewHeight);
    }];
}


#pragma mark - 按钮点击
-(void)selectButtonClick:(UIButton *)button
{
    self.languageButton = button;
    XMLanguageSelect *languageController = [[XMLanguageSelect alloc] init];
    languageController.delegate = self;
    languageController.selectLanguage = button.titleLabel.text;
    [self.navigationController pushViewController:languageController animated:YES];
}

-(void)centerButtonClick
{
    NSString *leftButtonStr = self.headerView.leftButton.titleLabel.text;
    NSString *rightButtonStr = self.headerView.rightButton.titleLabel.text;
    [self.headerView.leftButton setTitle:rightButtonStr forState:UIControlStateNormal];
    [self.headerView.rightButton setTitle:leftButtonStr forState:UIControlStateNormal];
}

/**
 *  点击发送
 */
-(void)sendButtonClick:(NSString *)content
{
    self.footView.textField.text = nil;
    self.footView.sendButton.enabled = NO;
    
    [MBProgressHUD showMessage:@"正在翻译,请稍等..."];
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q, ^{
        //获取翻译信息
        NSString *fromCode = [self.db selectCodeWithLanguage:self.headerView.leftButton.titleLabel.text];
        NSString *toCode = [self.db selectCodeWithLanguage:self.headerView.rightButton.titleLabel.text];
        XMBaiduAccount *account = [XMBaiduAccount accountWithContent:content fromLanguageCode:fromCode toLanguageCode:toCode];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:account.url parameters:[account accountDict] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //保存翻译信息到数据库
            XMTranslateModel *model = [XMTranslateModel modelWithDict:responseObject];
            [self.db insertDataToTranslate:model];
            //添加新的翻译信息到数组
            XMTranslateViewCellFrame *newFrame = [[XMTranslateViewCellFrame alloc] init];
            newFrame.model = model;
            [self.translateArray addObject:newFrame];
            //更新ui
            dispatch_async(dispatch_get_main_queue(), ^{
                // 刷新表格
                NSIndexPath *path = [NSIndexPath indexPathForRow:self.translateArray.count - 1 inSection:0];
                [self.centerView reloadData];
                // 滚动到最底部
                [self.centerView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                [MBProgressHUD hideHUD];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD hideHUD];
            [XMSetTravelTool showToast:@"亲,你的网络不行哟" view:self.view];
        }];
    });
}

/**
 *  选择语言回调
 */
-(void)selectLanguageCallBack:(NSString *)languageName
{
    [self.languageButton setTitle:languageName forState:UIControlStateNormal];
}

/**
 *  移除消息
 */
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.translateArray == nil) return 0;
    return self.translateArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    XMTranslateViewCell *cell = [XMTranslateViewCell cellWithTableView:tableView];
    //传递模型
    XMTranslateViewCellFrame *frame = self.translateArray[indexPath.row];
    cell.frameModel = frame;
    return cell;
}
/**
 *  设置tableView高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMTranslateViewCellFrame *frame = self.translateArray[indexPath.row];
    return frame.cellHeight;
}
/**
 *  设置tableView可编辑
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
/**
 *  定义编辑样式
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
}
// 进入编辑模式，按下出现的编辑按钮后

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除数据库内容
    XMTranslateViewCellFrame *frame = self.translateArray[indexPath.row];
    [self.db deleteTranslateDataWithSrc:frame.model.src];
    
    //删除tableView内容
    [self.translateArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

/**
 *  修改编辑按钮的文字
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/**
 *  当用户触屏tableView的时候退出键盘
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end

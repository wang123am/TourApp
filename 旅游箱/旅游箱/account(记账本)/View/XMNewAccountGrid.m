//
//  XMNewAccountGrid.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/26.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMNewAccountGrid.h"
#import "XMNewAccountGridItem.h"

#define gridItemCount 10
#define viewHeight self.frame.size.height
#define viewWidth self.frame.size.width
#define margin 10 
#define itemWidth ((viewWidth-6*margin)/(gridItemCount*0.5))
@interface XMNewAccountGrid()<UIScrollViewDelegate,XMNewAccountGridItemDelegate>
@property (nonatomic,strong) NSArray *gridItemTextArray;
@property (nonatomic,strong) NSMutableArray *gridItemArray;
@property (nonatomic,weak) UIImageView *topView;
@property (nonatomic,weak) UIScrollView *centerView;
@property (nonatomic,weak) UIImageView *buttomView;
@property (nonatomic,weak) UIImageView *pageImgView;

@end

@implementation XMNewAccountGrid
-(NSMutableArray *)gridItemArray
{
    if (!_gridItemArray) _gridItemArray = [NSMutableArray array];
    return _gridItemArray;
}
-(NSArray *)gridItemTextArray
{
    if (_gridItemTextArray == nil) {
        _gridItemTextArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newAccountItemText" ofType:@"plist"]];
    }
    return _gridItemTextArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_shadow"]];
        self.topView = topView;
        [self addSubview:topView];
        
        UIScrollView *centerView = [[UIScrollView alloc] init];
        centerView.delegate = self;
        centerView.backgroundColor = [UIColor whiteColor];
        self.centerView = centerView;
        [self addSubview:centerView];
        for (int i = 0 ;i < gridItemCount; i++) {
            XMNewAccountGridItem *item = [XMNewAccountGridItem gridItemWithName:self.gridItemTextArray[i] nomImg:[UIImage imageNamed:[NSString stringWithFormat:@"account_page_griditem_%d_normal",i]] selectImg:[UIImage imageNamed:[NSString stringWithFormat:@"account_page_griditem_%d_pressed",i]]];
            item.delegate = self;
            [centerView addSubview:item];
            [self.gridItemArray addObject:item];
        }
        
        centerView.contentSize = CGSizeMake(gridItemCount*itemWidth+(gridItemCount+1)*margin, 0);
        centerView.showsHorizontalScrollIndicator = NO;
        centerView.pagingEnabled = YES;
        
        UIImageView *buttomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account_page_shadow"]];
        self.buttomView = buttomView;
        [self addSubview:buttomView];
       
        UIImageView *pageImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_page_firstscreen_point"]];
        pageImgView.contentMode = UIViewContentModeCenter;
        self.pageImgView = pageImgView;
        [self addSubview:pageImgView];
        //默认选中第一个
        self.selectItem = self.gridItemArray[0];
        [self gridItemButtonClick:self.gridItemArray[0]];
     
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat shadowViewH = 5;
    self.topView.frame = CGRectMake(0, 0, viewWidth, shadowViewH);
    self.centerView.frame = CGRectMake(0, shadowViewH, viewWidth, viewHeight-2*shadowViewH);
    self.buttomView.frame = CGRectMake(0, viewHeight-shadowViewH, viewWidth, shadowViewH);
    CGFloat itemHeight = 60;
    for (int i = 0; i < self.gridItemArray.count; i++) {
        XMNewAccountGridItem *item = self.gridItemArray[i];
        CGFloat itemX = margin + (margin+itemWidth)*i;
        item.frame = CGRectMake(itemX, 0, itemWidth, itemHeight);
    }
    self.pageImgView.frame = CGRectMake(0, self.centerView.frame.size.height-15, viewWidth, 5);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //滚动时设置分页图片
    int index = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    if(index){
        [self.pageImgView setImage:[UIImage imageNamed:@"main_page_secondscreen_point"]];
    } else {
        [self.pageImgView setImage:[UIImage imageNamed:@"main_page_firstscreen_point"]];
    }
}

-(void)gridItemButtonClick:(XMNewAccountGridItem *)selectItem
{
    if (self.selectItem == selectItem) {
        return;
    }
    //设置图片
    self.selectItem.imgButton.selected = NO;
    selectItem.imgButton.selected = YES;
    //设置文字
    self.selectItem.nameLabel.textColor = [UIColor grayColor];
    selectItem.nameLabel.textColor = [UIColor blackColor];
    self.selectItem = selectItem;
}
@end

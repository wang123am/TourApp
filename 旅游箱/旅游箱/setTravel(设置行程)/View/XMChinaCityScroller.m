//
//  XMChinaCityScroller.m
//  XMTour
//
//  Created by 梁亦明 on 15/3/7.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import "XMChinaCityScroller.h"
#import "XMCityTitle.h"

#define titleHeight 30
#define viewWidth self.frame.size.width
#define hotCityCol 3
#define letterCol 5

@interface XMChinaCityScroller()
@property (nonatomic,weak) XMCityTitle *hotCityTitle;
@property (nonatomic,weak) XMCityTitle *retrieveTitle;
@property (nonatomic,strong) NSMutableArray *hotCityArray;
@property (nonatomic,strong) NSMutableArray* letterArray;
@end

@implementation XMChinaCityScroller
-(NSMutableArray*)hotCityArray
{
    if (_hotCityArray == nil) {
        self.hotCityArray = [NSMutableArray array];
    }
    return _hotCityArray;
}

-(NSMutableArray *)letterArray
{
    if (_letterArray == nil) {
        self.letterArray = [NSMutableArray array];
    }
    return _letterArray;
}

+ (instancetype) scrollerWithCityArray:hotCityArray
{
    return [[self alloc] initWithCityArray:hotCityArray];
}
- (instancetype) initWithCityArray:(NSMutableArray *)hotCityArray
{
    if (self = [super init])
    {
        //添加热门城市标题
        XMCityTitle *hotCityTitle = [XMCityTitle titleWithName:@"热门城市"];
        self.hotCityTitle = hotCityTitle;
        [self addSubview:hotCityTitle];
        //添加热门城市按钮
        [self addListButton:hotCityArray buttonArray:self.hotCityArray];
        //添加快速检索标题
        XMCityTitle *retrieveTitle = [XMCityTitle titleWithName:@"快速检索"];
        self.retrieveTitle = retrieveTitle;
        [self addSubview:retrieveTitle];
        //添加快速检索按钮
        NSMutableArray *normalCityArray = [NSMutableArray array];
        for (char i = 'A'; i <= 'Z' ; i++){
            [normalCityArray addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [self addListButton:normalCityArray buttonArray:self.letterArray];
        //设置scroller属性
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}


//添加热门城市按钮和快速检索按钮
-(void) addListButton:(NSArray *)buttonCount buttonArray:(NSMutableArray *)array
{
    for (int i = 0; i < buttonCount.count; i++) {
        UIButton *listButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [listButton setBackgroundColor:[UIColor whiteColor]];
        [listButton setTitle:buttonCount[i] forState:UIControlStateNormal];
        [listButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [listButton addTarget:self action:@selector(listButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:listButton];
        [self addSubview:listButton];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //热门城市标题frame
    self.hotCityTitle.frame = CGRectMake(0, 0, viewWidth, titleHeight);
    //热门城市按钮frame
    [self setListButtonFrame:hotCityCol marginHeight:CGRectGetMaxY(self.hotCityTitle.frame) buttonArray:self.hotCityArray];
    //快速检索标题
    self.retrieveTitle.frame = CGRectMake(0, 230, viewWidth, 30);
    //快速检索按钮
    CGFloat lastButtonY = [self setListButtonFrame:letterCol marginHeight:CGRectGetMaxY(self.retrieveTitle.frame) buttonArray:self.letterArray];
    if ([self.delegate respondsToSelector:@selector(lastButtonHeight:)]) {
        [self.delegate lastButtonHeight:lastButtonY];
    }
}

/**
 *  设置热门按钮和快速检索按钮的frame
 *
 *  @param ButtonCount 按钮的列数
 *  @param height      上面一个空间的高度最大值Y
 */
-(CGFloat) setListButtonFrame:(long) ButtonCount marginHeight:(CGFloat)height buttonArray:(NSMutableArray*) array
{
    CGFloat listButtonMargin = 15;
    CGFloat listButtonW = (viewWidth - (ButtonCount + 1 ) * listButtonMargin)/ButtonCount;
    CGFloat listButtonH = 30;
    CGFloat listButtonY = 0;
    for(int i = 0 ; i < array.count ; i++){
        UIButton *listButton = array[i];
        int col = i / ButtonCount;
        int line = i % ButtonCount;
        CGFloat listButtonX = listButtonMargin + line * (listButtonMargin + listButtonW);
        listButtonY = height + listButtonMargin + col * (listButtonMargin + listButtonH);
        listButton.frame = CGRectMake(listButtonX, listButtonY, listButtonW, listButtonH);
    }
    return listButtonY+listButtonH;
}

/**
 *  列表按钮被点击时调用
 */
-(void)listButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(listButtonClick:)]) {
        [self.delegate listButtonClick:button.titleLabel.text];
    }
}

@end

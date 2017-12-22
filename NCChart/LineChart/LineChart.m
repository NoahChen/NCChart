//
//  LineChar.m
//  IntelligentStreetLamp
//
//  Created by 瑞琪 on 2017/3/31.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import "LineChart.h"
#import "LineView.h"
#import "HorizontalAxisLineView.h"

#define COOR_START_X 40
#define COOR_END_X SCREEN_WIDTH-20
#define COOR_START_Y 20
#define COOR_HEIGHT 200

@interface LineChart () <UIScrollViewDelegate> {
    UIScrollView *_scrollview;
    LineView *_lineView;
    HorizontalAxisLineView *_horLineView;
    id _superView;
}

//点的数量
@property (nonatomic, assign) NSInteger pointCount;
@property (nonatomic, strong) LineView *lineView;

@end

@implementation LineChart

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addLineChartWithAbscissaTitles:(NSArray *)abscissaTitleArr lineArr:(NSArray *)lineArr {
    [self createHorizontalAxisLineView];
    if (self.widthVariable == YES) {
        [self createScrollView];
        _superView = _scrollview;
    }
    else {
        _superView = self;
    }
    [self loadLineViewWithAbscissaTitles:abscissaTitleArr lineArr:lineArr];
}

#pragma mark - 左右滑动ScrollView
- (void)createScrollView {
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(COOR_START_X, COOR_START_Y, COOR_END_X-COOR_START_X, COOR_HEIGHT)];
    _scrollview.delegate = self;
    _scrollview.contentSize = CGSizeMake(600, 0);
    _scrollview.bounces = NO;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.backgroundColor = [UIColor redColor];
    [self addSubview:_scrollview];
}

#pragma mark - 折线视图
- (void)loadLineViewWithAbscissaTitles:(NSArray *)abscissaTitleArr lineArr:(NSArray *)lineArr {
    if (self.lineView != nil) {
        [self.lineView removeFromSuperview];
        self.lineView = nil;
    }
    self.lineView = [[LineView alloc] initWithFrame:CGRectMake(COOR_START_X, COOR_START_Y, COOR_END_X-COOR_START_X, self.frame.size.height-COOR_START_Y)];
    self.lineView.abscissaTitleArr = abscissaTitleArr;
    self.lineView.lineArr = lineArr;
    [_superView addSubview:self.lineView];
}

#pragma mark - 纵坐标标线视图
- (void)createHorizontalAxisLineView {
    _horLineView = [[HorizontalAxisLineView alloc] initWithFrame:CGRectMake(0, 0, COOR_END_X, self.frame.size.height)];
    [self addSubview:_horLineView];
}

@end



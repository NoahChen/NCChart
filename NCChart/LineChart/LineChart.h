//
//  LineChart.h
//  IntelligentStreetLamp
//
//  Created by 瑞琪 on 2017/4/11.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LineChartDelegate <NSObject>

- (void)addLineChart;

@end

@interface LineChart : UIView

@property (nonatomic, assign) id<LineChartDelegate> delegate;
/*
 * 宽度是否可变
 */
@property (nonatomic, assign) BOOL widthVariable;

/*
 * 点的数组
 */
@property (nonatomic, strong) NSArray *pointArr;

/*
 * 折线图
 */
- (void)addLineChartWithAbscissaTitles:(NSArray *)abscissaTitleArr lineArr:(NSArray *)lineArr;

/*
 * 折线
 */
- (void)loadLineViewWithAbscissaTitles:(NSArray *)abscissaTitleArr lineArr:(NSArray *)lineArr;

@end

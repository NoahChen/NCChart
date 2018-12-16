//
//  PieChartView.h
//  NCChartDemo
//
//  Created by 瑞琪 on 2017/2/7.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartView : UIView

@property (nonatomic, strong) UIFont *labelFont;

- (instancetype)initWithFrame:(CGRect)frame models:(NSArray *)models;

@end

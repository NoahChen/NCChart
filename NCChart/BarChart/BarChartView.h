//
//  BarChartView.h
//  NCChartDemo
//
//  Created by 瑞琪 on 2016/12/3.
//  Copyright © 2016年 cn.rich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CylinderButton.h"

@interface BarChartView : UIView

@property (nonatomic, strong) CylinderButton *cylinderBtn;
@property (nonatomic, strong) UIScrollView *scrollView;

- (instancetype)initWithFrame:(CGRect)frame numbers:(NSArray <NSNumber *> *)numberArr titles:(NSArray <NSString *> *)titleArr;

- (void)reloadBarChartWithNumbers:(NSArray <NSNumber *> *)numberArr titles:(NSArray <NSString *> *)titleArr;

@end


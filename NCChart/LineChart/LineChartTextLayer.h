//
//  LineChartTextLayer.h
//  IntelligentStreetLamp
//
//  Created by 瑞琪 on 2017/4/11.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface LineChartTextLayer : CATextLayer

@property (nonatomic, assign) CGFloat textSize;
@property (nonatomic, copy) NSString *text;

- (LineChartTextLayer *)layer;

@end

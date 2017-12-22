//
//  HorizontalAxisLineView.m
//  IntelligentStreetLamp
//
//  Created by 瑞琪 on 2017/4/11.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import "HorizontalAxisLineView.h"
#import "LineChartTextLayer.h"

#define COOR_START_X 40
#define COOR_END_X SCREEN_WIDTH-20
#define COOR_START_Y 20
#define COOR_HEIGHT 200

@implementation HorizontalAxisLineView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //纵坐标坐标点标线
    float spacing = COOR_HEIGHT/4;
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ref);
    for (int i = 0; i<5; i++) {
        //if (i != 4) {
            CGContextMoveToPoint(ref, COOR_START_X, COOR_START_Y+spacing*i);
            CGContextAddLineToPoint(ref, COOR_END_X, COOR_START_Y+spacing*i);
            CGContextSetLineWidth(ref, 0.5);
            CGContextSetStrokeColorWithColor(ref, CUTTINGLINE_COLOR.CGColor);
        //}
        if (i == 0) {
            CGContextRestoreGState(ref);
        }
        
        //纵坐标坐标点
        LineChartTextLayer *textLayer = [LineChartTextLayer layer];
        textLayer.bounds = CGRectMake(0, 0, 30, 14);
        textLayer.anchorPoint = CGPointMake(0.5, 0.5);
        textLayer.position = CGPointMake(20, COOR_START_Y+spacing*i);
        textLayer.textSize = 12;
        textLayer.text = [NSString stringWithFormat:@"%d%@", (int)(100-100.0/4.0*i), @"%"];
        [self.layer addSublayer:textLayer];
    }
    CGContextStrokePath(ref);
}

@end

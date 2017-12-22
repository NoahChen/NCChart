//
//  LineView.m
//  IntelligentStreetLamp
//
//  Created by 瑞琪 on 2017/4/1.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import "LineView.h"
#import "LinePoint.h"
#import "LinePointView.h"
#import "LineChartTextLayer.h"

#define COOR_START_X 40
#define COOR_END_X SCREEN_WIDTH-20
#define COOR_START_Y 20
#define COOR_HEIGHT 200

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
//    NSArray *yAxisArr = @[@"50", @"100", @"75", @"123", @"136", @"63", @"90"];
//    NSArray *timeArr = @[@"03/21", @"03/22", @"03/23", @"03/24", @"03/25", @"03/26", @"03/27"];
//    NSArray *titleArr = @[@"30%", @"50%", @"60%", @"50%", @"30%", @"50%", @"70%"];
    
    float x_spacing = self.frame.size.width/7;
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ref);
    for (int i = 0; i<self.abscissaTitleArr.count; i++) {
        if (self.lineArr.count > 0) {
            float currentLineNum = 100 - [self.lineArr[i] floatValue];
            float currentPointHeight = currentLineNum/100*COOR_HEIGHT;
            if (i < self.lineArr.count-1) {
                float nextLineNum = 100 - [self.lineArr[i+1] floatValue];
                float nextPointHeight = nextLineNum/100*COOR_HEIGHT;
                
                CGContextMoveToPoint(ref, (x_spacing/2)+x_spacing*i, currentPointHeight);
                CGContextAddLineToPoint(ref, (x_spacing/2)+x_spacing*(i+1), nextPointHeight);
                CGContextSetLineWidth(ref, 1.0);
                CGContextSetStrokeColorWithColor(ref, [UIColor redColor].CGColor);
                if (i == 0) {
                    CGContextRestoreGState(ref);
                }
            }
            
            //折线节点
            LinePointView *pointView = [[LinePointView alloc] initWithRadius:5 center:CGPointMake((x_spacing/2)+x_spacing*i, currentPointHeight)];
            [self addSubview:pointView];
            
            LinePoint *pointBtn = [[LinePoint alloc] initWithRadius:20 center:CGPointMake((x_spacing/2)+x_spacing*i, currentPointHeight)];
            pointBtn.tag = 3000+i;
            [pointBtn addTarget:self action:@selector(touchPoint:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:pointBtn];
            
            //折线节点textLayer
            LineChartTextLayer *pointTextLayer = [LineChartTextLayer layer];
            pointTextLayer.bounds = CGRectMake(0, 0, 30, 20);
            pointTextLayer.anchorPoint = CGPointMake(0.5, 0.5);
            pointTextLayer.position = CGPointMake(pointBtn.center.x, pointBtn.frame.origin.y-7);
            pointTextLayer.textSize = 12;
            pointTextLayer.text = self.lineArr[i];
            pointTextLayer.contentsScale = [UIScreen mainScreen].scale;
            [self.layer addSublayer:pointTextLayer];
        }
        
        //横坐标textLayer
        LineChartTextLayer *textLayer = [LineChartTextLayer layer];
        textLayer.bounds = CGRectMake(0, 0, x_spacing, 15);
        textLayer.anchorPoint = CGPointMake(0, 0);
        textLayer.position = CGPointMake(x_spacing*i, COOR_START_Y+COOR_HEIGHT);
        textLayer.textSize = 11;
        textLayer.text = self.abscissaTitleArr[i];
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:textLayer];
    }
    CGContextStrokePath(ref);
}

#pragma mark - 点击事件
- (void)touchPoint:(UIButton *)sender {
//    NSArray *array = @[@"line", [NSNumber numberWithInteger:sender.tag-3000]];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"chart" object:array];
}

@end


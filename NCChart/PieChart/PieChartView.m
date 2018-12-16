//
//  PieChartView.m
//  NCChartDemo
//
//  Created by 瑞琪 on 2017/2/7.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import "PieChartView.h"
#import "PieCenterView.h"
#import "PieDataModel.h"

#define RADIUS 100 //外侧半径
#define INSIDE_RADIUS 65 //内测半径
#define TEXT_FROM_CENTER (RADIUS*2/3) //文字中心点与圆心的距离
#define LINEBEGIN_FROM_CENTER (RADIUS+10) //指示线起点与圆心距离
#define LINEEND_FROM_CENTER (RADIUS+30) //指示线拐点与圆心距离

@interface PieChartView () {
    UIView *_textView;
}

@property (nonatomic, strong) NSArray *models;
@property (nonatomic, assign) int total;

@end

@implementation PieChartView

- (instancetype)initWithFrame:(CGRect)frame models:(NSArray *)models {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.labelFont = [UIFont systemFontOfSize:13];
        //[self drawCircle];
        self.models = models;
    }
    return self;
}

//扇形
- (void)createShapeLayerWithColor:(UIColor *)color title:(NSString *)title percent:(NSString *)percent path:(CGPathRef)path startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 35.0;
    shapeLayer.strokeColor = nil;
    shapeLayer.fillColor = color.CGColor;
    shapeLayer.path = path;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    [self.layer addSublayer:shapeLayer];
    
    NSString *percentStr = [NSString stringWithFormat:@"%.0f%@", [percent intValue]/360.0*100, @"%"];//文字字符串
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    CGFontRef font = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        font = CGFontCreateCopyWithVariations((__bridge CGFontRef)(self.labelFont), (__bridge CFDictionaryRef)(@{}));
    } else {
        font = CGFontCreateWithFontName((__bridge CFStringRef)[self.labelFont fontName]);
    }
    if (font) {
        [textLayer setFont:font];
        CFRelease(font);
    }
    
    textLayer.fontSize = self.labelFont.pointSize;
    textLayer.anchorPoint = CGPointMake(0.5, 0.5);
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.backgroundColor = [UIColor clearColor].CGColor;
    textLayer.foregroundColor = color.CGColor;
    
    NSDictionary *labelFont = @{NSFontAttributeName:self.labelFont};
    CGSize size = [@"12" sizeWithAttributes:labelFont];
    [CATransaction setDisableActions:YES];
    textLayer.frame = CGRectMake(0, 0, 3*size.width, 2*size.height);
    textLayer.string = [NSString stringWithFormat:@"%@\n%@", title, percentStr];
    [shapeLayer addSublayer:textLayer];
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    CGFloat halfAngle = (endAngle - startAngle)/2;
    //指示线
    CGPoint startPoint = CGPointMake(center.x + (LINEBEGIN_FROM_CENTER * cos(startAngle+halfAngle)), center.y + (LINEBEGIN_FROM_CENTER * sin(startAngle+halfAngle)));
    CGPoint centerPoint = CGPointMake(center.x + (LINEEND_FROM_CENTER * cos(startAngle+halfAngle)), center.y + (LINEEND_FROM_CENTER * sin(startAngle+halfAngle)));
    
    CGPoint endPoint = CGPointMake(centerPoint.x + 50, centerPoint.y);
    if (startAngle+halfAngle > M_PI_2 && startAngle+halfAngle < M_PI_2*3) {
        endPoint = CGPointMake(centerPoint.x - 50, centerPoint.y);
    }
    
    //指示线起点的点
    UIBezierPath *startPointPath = [UIBezierPath bezierPathWithArcCenter:startPoint radius:3.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *startPointLayer = [CAShapeLayer layer];
    startPointLayer.path = startPointPath.CGPath;
    startPointLayer.fillColor = color.CGColor;
    [shapeLayer addSublayer:startPointLayer];
    
    //指示线layer
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint: startPoint];
    [linePath addLineToPoint:centerPoint];
    [linePath addLineToPoint:endPoint];
    linePath.lineWidth = 1.0;
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1.0;
    lineLayer.path = linePath.CGPath;
    lineLayer.strokeColor = color.CGColor;
    lineLayer.fillColor = nil;
    [shapeLayer addSublayer:lineLayer];
    
    //文字
    if (startAngle+halfAngle > M_PI/2 && startAngle+halfAngle < M_PI*3/2) {
        [textLayer setPosition:CGPointMake(centerPoint.x - 25, centerPoint.y + 15)];
    } else {
        [textLayer setPosition:CGPointMake(centerPoint.x + 25, centerPoint.y + 15)];
    }
}

//饼图绘制
- (void)drawRect:(CGRect)rect {
    CGPoint circleCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat startAngle = 0;
    for (int i = 0; i<self.models.count; i++) {
        PieDataModel *model = self.models[i];
        
        CGFloat endAngle = startAngle + [model.num intValue]/180.0*M_PI;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(circleCenter.x + (RADIUS * cos(startAngle)), circleCenter.y + (RADIUS * sin(startAngle)))];
        //内弧
        [path addArcWithCenter:circleCenter radius:INSIDE_RADIUS startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        [path addLineToPoint:CGPointMake(circleCenter.x + (RADIUS * cos(endAngle)), circleCenter.y + (RADIUS * sin(endAngle)))];
        
        //外弧
        [path addArcWithCenter:circleCenter radius:RADIUS startAngle:endAngle endAngle:startAngle clockwise:NO];
        [path closePath];

        model.startAngle = startAngle;
        model.endAngle = endAngle;
        CGFloat halfAngle = (endAngle - startAngle)/2;
        model.halfAngle = halfAngle;
        
        [self createShapeLayerWithColor:model.color title:model.name percent:[NSString stringWithFormat:@"%@", model.num] path:path.CGPath startAngle:startAngle endAngle:endAngle];
        
        startAngle = endAngle;
    }
    
    //中间的圆
//    PieCenterView *centerView = [[PieCenterView alloc] init];
//
//    centerView.frame = CGRectMake(0, 0, 150, 150);
//
//    CGRect frame = centerView.frame;
//    frame.origin = CGPointMake(self.frame.size.width * 0.5 - frame.size.width * 0.5, self.frame.size.height * 0.5 - frame.size.width * 0.5);
//    centerView.frame = frame;
//
//    centerView.nameLabel.text = @"文字";
//
//    [self addSubview:centerView];
}

- (void)getCurrentSelectedOnTouch:(CGPoint)point type:(int)type {
    __block NSInteger selectIndex = -1;
    __block CAShapeLayer *selectShapelayer = [CAShapeLayer layer];
    CGAffineTransform transform = CGAffineTransformIdentity;
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            CAShapeLayer *shapeLayer = (CAShapeLayer *)obj;
            CGPathRef path = shapeLayer.path;
            
            if (CGPathContainsPoint(path, &transform, point, 0)) {
                selectIndex = idx;
                NSLog(@"点击的部分------%ld",(long)selectIndex);
                selectShapelayer = shapeLayer;
                
                [self previousSelectedShapeLayerPositionBackWithCurrentSelectedShapLayer:shapeLayer];
                
                PieDataModel *model = self.models[idx];
                __block CGPoint layerPosition = shapeLayer.position;
                [UIView animateWithDuration:0.5 animations:^{
                    if (model.isSelected) {
                        layerPosition = CGPointMake(layerPosition.x - (5 * cos(model.startAngle+model.halfAngle)), layerPosition.y - (5 * sin(model.startAngle+model.halfAngle)));
                    } else {
                        layerPosition = CGPointMake(layerPosition.x + (5 * cos(model.startAngle+model.halfAngle)), layerPosition.y + (5 * sin(model.startAngle+model.halfAngle)));
                    }
                    shapeLayer.position = layerPosition;
                } completion:^(BOOL finished) {
                    if (finished) {
                        model.isSelected = !model.isSelected;
                    }
                }];
            }
        }
    }];
//    return selectIndex;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    //得到触摸点
    CGPoint point = [[touches anyObject] locationInView:self];
//    NSInteger selectIndex = [self getCurrentSelectedOnTouch:point type:0];
//    NSLog(@"点击的部分------%ld",(long)selectIndex);
    [self getCurrentSelectedOnTouch:point type:0];
}

- (void)previousSelectedShapeLayerPositionBackWithCurrentSelectedShapLayer:(CAShapeLayer *)currentSelectedShapeLayer {
    for (int i = 0; i<self.layer.sublayers.count; i++) {
        CALayer *layer = self.layer.sublayers[i];
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            PieDataModel *model = self.models[i];
            CAShapeLayer *shapeLayer = (CAShapeLayer *)layer;
            if(![shapeLayer isEqual:currentSelectedShapeLayer] && model.isSelected) {
                __block CGPoint layerPosition = shapeLayer.position;
                [UIView animateWithDuration:0.5 animations:^{
                    layerPosition = CGPointMake(layerPosition.x - (5 * cos(model.startAngle+model.halfAngle)), layerPosition.y - (5 * sin(model.startAngle+model.halfAngle)));
                    shapeLayer.position = layerPosition;
                } completion:^(BOOL finished) {
                    if (finished) {
                        model.isSelected = !model.isSelected;
                    }
                }];
                break;
            }
        }
    }
}

@end







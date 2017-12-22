//
//  CylinderButton.m
//  NCChartDemo
//
//  Created by 瑞琪 on 2016/12/5.
//  Copyright © 2016年 cn.rich. All rights reserved.
//

#import "CylinderButton.h"

@implementation CylinderButton {
    CAShapeLayer *_layer;
    id _target;
    SEL _action;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        _layer = [CAShapeLayer layer];
        _layer.path = path.CGPath;
        [_layer setFillColor:[UIColor blueColor].CGColor];
        [self.layer addSublayer:_layer];
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [self.layer convertPoint:point toLayer:_layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:_layer.path];
    if ([path containsPoint:point]) {
        if ([_target respondsToSelector:_action]) {
            [_target performSelectorOnMainThread:_action withObject:nil waitUntilDone:NO];
        }
    }
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    _target = target;
    _action = action;
}

@end

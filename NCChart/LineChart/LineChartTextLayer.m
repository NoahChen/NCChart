//
//  LineChartTextLayer.m
//  IntelligentStreetLamp
//
//  Created by 瑞琪 on 2017/4/11.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import "LineChartTextLayer.h"

@implementation LineChartTextLayer

- (LineChartTextLayer *)layer {
    LineChartTextLayer *layer = [[LineChartTextLayer alloc] init];
    return layer;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setTextSize:(CGFloat)textSize {
    UIFont *font = [UIFont systemFontOfSize:textSize];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    self.font = fontRef;
    self.fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

- (void)setText:(NSString *)text {
    self.foregroundColor = [UIColor darkGrayColor].CGColor;
    self.alignmentMode = kCAAlignmentCenter;
    self.contentsScale = [UIScreen mainScreen].scale;
    self.wrapped = YES;
    self.string = text;
}

@end

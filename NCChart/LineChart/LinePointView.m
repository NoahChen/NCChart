//
//  LinePointView.m
//  IntelligentStreetLamp
//
//  Created by 瑞琪 on 2017/5/10.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import "LinePointView.h"

@implementation LinePointView

- (instancetype)initWithRadius:(CGFloat)radius center:(CGPoint)center {
    if (self = [super init]) {
        
        CGRect rect = self.bounds;
        rect.size = CGSizeMake(radius*2, radius*2);
        self.bounds = rect;
        
        self.center = center;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
        //        self.layer.borderWidth = 10.0;
        //        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end

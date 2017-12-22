//
//  LinePoint.h
//  IntelligentStreetLamp
//
//  Created by 瑞琪 on 2017/4/11.
//  Copyright © 2017年 cn.rich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinePoint : UIButton

/*
 * @param radius: 半径
 * @param center: 圆心
 */
- (instancetype)initWithRadius:(CGFloat)radius center:(CGPoint)center;

@end

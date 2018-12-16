//
//  PieDataModel.h
//  Example
//
//  Created by 企鹅iOS陈方舟 on 2018/12/14.
//  Copyright © 2018 陈方舟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PieDataModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSNumber *num;
@property (nonatomic, assign) NSInteger *total;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) float startAngle;
@property (nonatomic, assign) float endAngle;
@property (nonatomic, assign) float halfAngle;

+ (id)modelWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

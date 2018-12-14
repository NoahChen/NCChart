//
//  PieDataModel.m
//  Example
//
//  Created by 企鹅iOS陈方舟 on 2018/12/14.
//  Copyright © 2018 陈方舟. All rights reserved.
//

#import "PieDataModel.h"

@implementation PieDataModel

+ (id)modelWithDictionary:(NSDictionary *)dic {
    PieDataModel *model = [[PieDataModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

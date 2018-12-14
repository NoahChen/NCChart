//
//  PieCenterView.h
//  Example
//
//  Created by 企鹅iOS陈方舟 on 2018/12/14.
//  Copyright © 2018 陈方舟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PieCenterView : UIView

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) PieDataModel *dataModel;

@end

NS_ASSUME_NONNULL_END

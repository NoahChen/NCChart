//
//  BarChartViewController.m
//  NCChartDemo
//
//  Created by 瑞琪 on 2016/12/3.
//  Copyright © 2016年 cn.rich. All rights reserved.
//

#import "BarChartViewController.h"
#import "BarChartView.h"

@interface BarChartViewController () <UIScrollViewDelegate> {
    
}

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BarChartView *bcv = [[BarChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) numbers:@[@100, @50, @70, @35] titles:@[@"标题一", @"标题二", @"标题三", @"标题四"]];
    [self.view addSubview:bcv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

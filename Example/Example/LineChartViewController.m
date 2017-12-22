//
//  LineChartViewController.m
//  NCChartDemo
//
//  Created by 瑞琪 on 2016/12/3.
//  Copyright © 2016年 cn.rich. All rights reserved.
//

#import "LineChartViewController.h"
#import "LineChart.h"

@interface LineChartViewController ()

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    LineChart *lineChart = [[LineChart alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 270)];
    //lineChar.pointArr = @[@"1", @"2"];
    lineChart.widthVariable = NO;
    [lineChart addLineChartWithAbscissaTitles:@[@"标题", @"标题", @"标题", @"标题", @"标题", @"标题", @"标题"] lineArr:@[@"70%", @"97%", @"50%", @"93%", @"30%", @"63%", @"85%"]];
    [self.view addSubview:lineChart];
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

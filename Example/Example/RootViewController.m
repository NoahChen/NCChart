//
//  RootViewController.m
//  NCChartDemo
//
//  Created by 瑞琪 on 2016/12/3.
//  Copyright © 2016年 cn.rich. All rights reserved.
//

#import "RootViewController.h"
#import "BarChartViewController.h"
#import "PieChartViewController.h"
#import "LineChartViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)barChartBtn {
    BarChartViewController *bcvc = [[BarChartViewController alloc] init];
    bcvc.title = @"柱状图";
    [self.navigationController pushViewController:bcvc animated:YES];
}

- (IBAction)pieChartBtn {
    PieChartViewController *pcvc = [[PieChartViewController alloc] init];
    pcvc.title = @"饼图";
    [self.navigationController pushViewController:pcvc animated:YES];
}

- (IBAction)lineChart {
    LineChartViewController *lcvc = [[LineChartViewController alloc] init];
    lcvc.title = @"折线图";
    [self.navigationController pushViewController:lcvc animated:YES];
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

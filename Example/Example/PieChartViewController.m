//
//  PieChartViewController.m
//  NCChartDemo
//
//  Created by 瑞琪 on 2016/12/3.
//  Copyright © 2016年 cn.rich. All rights reserved.
//

#import "PieChartViewController.h"
#import "PieChartView.h"
#import "PieDataModel.h"

@interface PieChartViewController ()

@end

@implementation PieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *percentArr = @[@60, @20, @90, @190];
    NSArray *titleArr = @[@"part1", @"part2", @"part3", @"part4"];
    NSArray *colorArr = @[[UIColor redColor],
                          [UIColor yellowColor],
                          [UIColor orangeColor],
                          [UIColor greenColor]];
    
    NSMutableArray *modelArr = [NSMutableArray array];
    NSArray *dataArr = @[
                         @{
                             @"name": @"工作",
                             @"num": @(225),
                             @"color": [UIColor redColor]
                             },
                         @{
                             @"name": @"空闲",
                             @"num": @(90),
                             @"color": [UIColor blueColor]
                             },
                         @{
                             @"name": @"离线",
                             @"num": @(30),
                             @"color": [UIColor orangeColor]
                             },
                         @{
                             @"name": @"故障",
                             @"num": @(15),
                             @"color": [UIColor greenColor]
                             },
                         ];
    
    for (NSDictionary *dic in dataArr) {
        [modelArr addObject:[PieDataModel modelWithDictionary:dic]];
    }
    
    PieChartView *pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) models:modelArr];
    [self.view addSubview:pieChartView];
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

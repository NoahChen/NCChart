//
//  BarChartView.m
//  NCChartDemo
//
//  Created by 瑞琪 on 2016/12/3.
//  Copyright © 2016年 cn.rich. All rights reserved.
//

#import "BarChartView.h"

#define COOR_X 50 //坐标系宽度起始位置
#define COOR_Y 100  //坐标系高度起始位置
#define COOR_WIDTH ([UIScreen mainScreen].bounds.size.width-65) //坐标系宽度
#define COOR_HEIGHT 400 //坐标系高度

@implementation BarChartView

- (instancetype)initWithFrame:(CGRect)frame numbers:(NSArray <NSNumber *> *)numberArr titles:(NSArray <NSString *> *)titleArr {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createScrollView];
        [self addCylinderButtonWithNumbers:numberArr titles:titleArr];
    }
    return self;
}

//绘制坐标系
- (void)drawRect:(CGRect)rect {
    //坐标系
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextMoveToPoint(ctx, COOR_X, COOR_Y);
    CGContextAddLineToPoint(ctx, COOR_X, COOR_Y+COOR_HEIGHT);
    CGContextAddLineToPoint(ctx, COOR_X+COOR_WIDTH, COOR_Y+COOR_HEIGHT);
    CGContextStrokePath(ctx);
    
    //纵坐标点&纵坐标系数
    CGContextRestoreGState(ctx);
    float section_Y = COOR_HEIGHT/10.0;
    for (int i = 0; i<10; i++) {
        if (i != 9) {
            CGContextMoveToPoint(ctx, COOR_X-10, COOR_Y+section_Y*(i+1));
            CGContextAddLineToPoint(ctx, COOR_X, COOR_Y+section_Y*(i+1));
        }
        
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.bounds = CGRectMake(0, 0, 30, 14);
        textLayer.anchorPoint = CGPointMake(0.5, 0.5);
        textLayer.position = CGPointMake(25, COOR_Y+section_Y*(i+1));
        //textLayer.backgroundColor = [UIColor yellowColor].CGColor;
        
        //font
        UIFont *font = [UIFont systemFontOfSize:13];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        textLayer.font = fontRef;
        textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        
        //text
        textLayer.foregroundColor = [UIColor blackColor].CGColor;
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.wrapped = YES;
        textLayer.string = [NSString stringWithFormat:@"%d", 10-(i+1)];
        
        [self.layer addSublayer:textLayer];
    }
    CGContextStrokePath(ctx);
}

//ScrollView
- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(COOR_X, COOR_Y, COOR_WIDTH, COOR_HEIGHT+100)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
}

- (void)reloadBarChartWithNumbers:(NSArray <NSNumber *> *)numberArr titles:(NSArray <NSString *> *)titleArr {
    [self addCylinderButtonWithNumbers:numberArr titles:titleArr];
}

//柱子
- (void)addCylinderButtonWithNumbers:(NSArray <NSNumber *> *)numberArr titles:(NSArray <NSString *> *)titleArr {
    float cylinder_Width = 40.0;
    float spacing = 40.0;
    for (int i = 0; i<4; i++) {
        //柱形
        float cylinder_Height = [numberArr[i] floatValue];
        self.cylinderBtn = [[CylinderButton alloc] initWithFrame:CGRectMake(20+(cylinder_Width+spacing)*i, COOR_HEIGHT-cylinder_Height, cylinder_Width, cylinder_Height)];
        [self.cylinderBtn addTarget:self action:@selector(cycLinderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:self.cylinderBtn];
        
        //横坐标标签
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = titleArr[i];
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.font = [UIFont systemFontOfSize:12];
        textLabel.textColor = [UIColor blackColor];
        int textLabelLines;
        if (textLabel.text.length % 4 == 0) {
            textLabelLines = (int)(textLabel.text.length/4);
        }else{
            textLabelLines = (int)(textLabel.text.length/4) + 1;
        }
        //NSLog(@"行数------%d",textLabelLines);
        textLabel.frame = CGRectMake(self.cylinderBtn.frame.origin.x-10, COOR_HEIGHT, cylinder_Width+spacing/2, 24*textLabelLines);
        [_scrollView addSubview:textLabel];
    }
    _scrollView.contentSize = CGSizeMake(20+4*(cylinder_Width+spacing), 0);
}

- (void)cycLinderBtnClick:(CylinderButton *)sender {
    NSLog(@"点击柱状图");
}

@end



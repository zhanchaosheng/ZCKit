//
//  CodeScannerViewController.m
//  ZCKitDemo
//
//  Created by Cusen on 2017/4/28.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import "CodeScannerViewController.h"
#import <ZCKit/ZCKit.h>

/**
 *  屏幕 高 宽 边界
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds

#define TOP (SCREEN_HEIGHT-220)/2
#define LEFT (SCREEN_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)

@interface CodeScannerViewController ()<ZCCodeScannerDelegate>
@property (nonatomic, strong) ZCCodeScanner *codeScanner;
@end

@implementation CodeScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫描机器码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCodeScanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.codeScanner stopScan];
}

#pragma mark - ZCCodeScannerDelegate

- (void)didScannedCodeString:(NSString *)value {
    NSLog(@"Scanned value: %@",value);
    if (value.length > 0) {
        [self.codeScanner stopScan];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - private 

- (void)setupCodeScanner {
    self.codeScanner = [[ZCCodeScanner alloc] init];
    self.codeScanner.delegate = self;
    if ([self.codeScanner preparedScanner]) {
        //设置扫描区域
        CGFloat top = TOP/SCREEN_HEIGHT;
        CGFloat left = LEFT/SCREEN_WIDTH;
        CGFloat width = 220/SCREEN_WIDTH;
        CGFloat height = 220/SCREEN_HEIGHT;
        // top 与 left 互换  width 与 height 互换
        CGRect scanRect = CGRectMake(top, left, height, width);
        [self.codeScanner setScanRect:scanRect];
        
        CALayer *layer = [self.codeScanner getPreviewLayer];
        layer.frame = self.view.bounds;
        [self.view.layer addSublayer:layer];
        // 绘制扫描框视图
        [self setupScanningFrameView];
        [self.codeScanner startScan];
    }
}

- (void)setupScanningFrameView {
    // 绘制半透明背景
    CAShapeLayer *bgLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, kScanRect);
    CGPathAddRect(path, nil, self.view.bounds);
    [bgLayer setFillRule:kCAFillRuleEvenOdd];
    [bgLayer setPath:path];
    [bgLayer setFillColor:[UIColor blackColor].CGColor];
    [bgLayer setOpacity:0.6];
    [self.view.layer addSublayer:bgLayer];
    
    // 绘制扫描框
    UIImageView * scanFrameView = [[UIImageView alloc]initWithFrame:kScanRect];
    scanFrameView.image = [UIImage imageNamed:@"scanFrame"];
    [self.view addSubview:scanFrameView];
    
    // 绘制扫描线
    UIImageView *scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, 220, 2)];
    scanLine.image = [UIImage imageNamed:@"scanLine"];
    [self.view addSubview:scanLine];
    

    // 添加扫描线动画
    CGPoint position = scanLine.layer.position;
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position";
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(position.x,position.y+220-10)];
    positionAnimation.repeatDuration = INFINITY;
    positionAnimation.duration = 2.0f;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [scanLine.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
}


@end

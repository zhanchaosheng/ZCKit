//
//  ScannerViewController.m
//  ZCKitDemo
//
//  Created by Cusen on 2017/4/28.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import "ScannerViewController.h"
#import <ZCKit/ZCKit.h>

@interface ScannerViewController ()
@property (nonatomic, strong) ZCCodeDetection *codeScanner;
@end

@implementation ScannerViewController

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

#pragma mark - private 

- (void)setupCodeScanner {
    self.codeScanner = [[ZCCodeDetection alloc] init];
    
    UIView *previewView = [self.codeScanner getPreviewView];
    previewView.frame = self.view.bounds;
    [self.view addSubview:previewView];
    
    // 绘制扫描框视图
    [self setupScanningFrameView];
    
    [self.codeScanner startDetection];
}

- (void)setupScanningFrameView {
    // 绘制扫描框
    CAShapeLayer *scanningFrame = [CAShapeLayer layer];
    scanningFrame.strokeColor = [UIColor colorWithRed:0.172 green:0.671 blue:0.428 alpha:1.000].CGColor;
    scanningFrame.fillColor = nil;
    scanningFrame.lineWidth = 2.0f;
    CGFloat frameWidth = self.view.bounds.size.width - 100;
    scanningFrame.path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 64+50, frameWidth, frameWidth)].CGPath;
    
    [self.view.layer addSublayer:scanningFrame];
    
    // 绘制扫描线
    CAShapeLayer *scanningLine = [CAShapeLayer layer];
    scanningLine.strokeColor = [UIColor colorWithRed:0.172 green:0.671 blue:0.428 alpha:1.000].CGColor;
    scanningLine.fillColor = nil;
    scanningLine.lineWidth = 3.0f;
    CGFloat lineLenght = self.view.bounds.size.width - 110;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(55, 64+55)];
    [linePath addLineToPoint:CGPointMake(55+lineLenght-1, 64+55)];
    scanningLine.path = linePath.CGPath;
    
    [self.view.layer addSublayer:scanningLine];
    

    // 添加扫描线动画
    CGPoint position = scanningLine.position;
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position";
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(position.x,position.y+frameWidth-5)];
    positionAnimation.repeatDuration = INFINITY;
    //positionAnimation.autoreverses = YES;
    positionAnimation.duration = 2.0f;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [scanningLine addAnimation:positionAnimation forKey:@"positionAnimation"];
}

@end

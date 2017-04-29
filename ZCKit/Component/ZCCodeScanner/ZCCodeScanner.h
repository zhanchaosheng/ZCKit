//
//  ZCCodeScanner.h
//  ZCDemoUI
//
//  Created by Cusen on 2017/4/29.
//  Copyright © 2017年 zcs. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const ZCScannerErrorDomain;

typedef NS_ENUM(NSInteger, ZCScannerErrorCode) {
    ZCScannerErrorFailedToAddInput = 98,
    ZCScannerErrorFailedToAddOutput,
};

@class ZCCodeScanner;
@protocol ZCCodeScannerDelegate <NSObject>

- (void)didScannedCodeString:(NSString *)value;

@optional
- (void)failScan:(NSError **)error;

@end

@interface ZCCodeScanner : NSObject
@property (nonatomic, weak) id<ZCCodeScannerDelegate> delegate;

/// 初始化扫码环境
- (BOOL)preparedScanner;

/// 获取预览图层
- (CALayer *)getPreviewLayer;

/// 开始扫码
- (void)startScan;

/// 停止扫码
- (void)stopScan;

/// 限制设备的扫描区域，注意设备与屏幕的坐标系不同
- (void)setScanRect:(CGRect)rect;
@end

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

- (BOOL)preparedScanner;

- (CALayer *)getPreviewLayer;

- (void)startScan;

- (void)stopScan;
@end

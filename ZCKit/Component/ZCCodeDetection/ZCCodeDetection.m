//
//  ZCCodeDetection.m
//  ZCKit
//
//  Created by Cusen on 2017/4/23.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import "ZCCodeDetection.h"
#import "ZCCameraController.h"
#import "ZCPreviewView.h"

@interface ZCCodeDetection () <ZCCodeDetectionDelegate>

@property (nonatomic, strong) ZCPreviewView *previewView;
@property (nonatomic, strong) ZCCameraController *cameraController;

@end

@implementation ZCCodeDetection

- (instancetype)init {
    self = [super init];
    if (self) {
        _cameraController = [[ZCCameraController alloc] init];
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                  [UIScreen mainScreen].bounds.size.height);
        _previewView = [[ZCPreviewView alloc] initWithFrame:frame];
        if (![self preparedDetection]) {
            return nil;
        }
    }
    return self;
}
    
- (UIView *)getPreviewView {
    return self.previewView;
}
    
- (void)startDetection {
    [self.cameraController startSession];
}
    
- (void)stopDetection {
    [self.cameraController stopSession];
}

- (BOOL)preparedDetection {
    NSError *error;
    if ([self.cameraController setupSession:&error]) {
        
        [self.previewView setSession:self.cameraController.captureSession];
        self.cameraController.codeDetectionDelegate = self;
        
        return YES;
    } else {
        NSLog(@"Error: %@", [error localizedDescription]);
        return NO;
    }
}
    
#pragma mark - ZCCodeDetectionDelegate
    
- (void)didDetectCodes:(NSArray *)codes {
    NSArray *transformedCodes = [self.previewView transformedCodesFromCodes:codes];
    
    [self.previewView handelDetectCodes:transformedCodes];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (AVMetadataMachineReadableCodeObject *code in transformedCodes) {
            NSString *stringValue = code.stringValue;
            [self.delegate didDetectCodesString:stringValue];
        }
    });
}

@end

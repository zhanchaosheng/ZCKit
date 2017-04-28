//
//  ZCCameraController.m
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import "ZCCameraController.h"

@interface ZCCameraController () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureMetadataOutput *metadataOutput;
@end

@implementation ZCCameraController

- (NSString *)sessionPreset {
    return AVCaptureSessionPreset640x480;
}

- (BOOL)setupSessionInputs:(NSError *__autoreleasing *)error {
    BOOL success = [super setupSessionInputs:error];
    if (success) {
        if (self.activeCamera.autoFocusRangeRestrictionSupported) {

            if ([self.activeCamera lockForConfiguration:error]) {

                self.activeCamera.autoFocusRangeRestriction =
                            AVCaptureAutoFocusRangeRestrictionNear;

                [self.activeCamera unlockForConfiguration];
            }
        }
    }
    return success;
}

- (BOOL)setupSessionOutputs:(NSError **)error {
    self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];

    if ([self.captureSession canAddOutput:self.metadataOutput]) {
        [self.captureSession addOutput:self.metadataOutput];

        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        [self.metadataOutput setMetadataObjectsDelegate:self
                                                  queue:mainQueue];

        NSArray *types = @[AVMetadataObjectTypeQRCode,
                           AVMetadataObjectTypeAztecCode,
                           AVMetadataObjectTypeUPCECode];

        self.metadataOutput.metadataObjectTypes = types;

    } else {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:
                                       @"Failed to still image output."};
        *error = [NSError errorWithDomain:ZCCameraErrorDomain
                                     code:ZCCameraErrorFailedToAddOutput
                                 userInfo:userInfo];
        return NO;
    }

    return YES;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {

    [self.codeDetectionDelegate didDetectCodes:metadataObjects];

}



@end


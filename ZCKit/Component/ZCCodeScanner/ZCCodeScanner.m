//
//  ZCCodeScanner.m
//  ZCDemoUI
//
//  Created by Cusen on 2017/4/29.
//  Copyright © 2017年 zcs. All rights reserved.
//

#import "ZCCodeScanner.h"
#import <AVFoundation/AVFoundation.h>

NSString *const ZCScannerErrorDomain = @"com.cusen.ZCScannerErrorDomain";

@interface ZCCodeScanner ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *activeVideoInput;
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) dispatch_queue_t videoQueue;
@end

@implementation ZCCodeScanner


#pragma mark - public

- (BOOL)preparedScanner {
    NSError *error;
    if ([self setupSession:&error]) {
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    } else {
        NSLog(@"Error: %@", [error localizedDescription]);
        if ([self.delegate respondsToSelector:@selector(failScan:)]) {
            [self.delegate failScan:&error];
        }
        return NO;
    }
    return YES;
}

- (CALayer *)getPreviewLayer {
    return self.previewLayer;
}

- (void)startScan {
    if (![self.captureSession isRunning]) {
        dispatch_async(self.videoQueue, ^{
            [self.captureSession startRunning];
        });
    }
}

- (void)stopScan {
    if ([self.captureSession isRunning]) {
        dispatch_async(self.videoQueue, ^{
            [self.captureSession stopRunning];
        });
    }
}

- (void)setScanRect:(CGRect)rect {
    [self.metadataOutput setRectOfInterest:rect];
}

#pragma mark - getter & setter

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (_previewLayer == nil) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    }
    return _previewLayer;
}

#pragma mark - private

- (BOOL)setupSession:(NSError **)error {
    
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh; // AVCaptureSessionPreset640x480
    
    if (![self setupSessionInputs:error]) {
        return NO;
    }
    
    if (![self setupSessionOutputs:error]) {
        return NO;
    }
    
    self.videoQueue = dispatch_queue_create("com.cusen.VideoQueue", NULL);
    
    return YES;
}

- (BOOL)setupSessionInputs:(NSError *__autoreleasing *)error {
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice
                                                                             error:error];
    if (videoInput) {
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];
            self.activeVideoInput = videoInput;
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Failed to add video input."};
            *error = [NSError errorWithDomain:ZCScannerErrorDomain
                                         code:ZCScannerErrorFailedToAddInput
                                     userInfo:userInfo];
            return NO;
        }
    } else {
        return NO;
    }
    
    if (self.activeVideoInput.device.autoFocusRangeRestrictionSupported) {
        
        if ([self.activeVideoInput.device lockForConfiguration:error]) {
            
            self.activeVideoInput.device.autoFocusRangeRestriction =
            AVCaptureAutoFocusRangeRestrictionNear;
            
            [self.activeVideoInput.device unlockForConfiguration];
        }
    }
    return YES;
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
        *error = [NSError errorWithDomain:ZCScannerErrorDomain
                                     code:ZCScannerErrorFailedToAddOutput
                                 userInfo:userInfo];
        return NO;
    }
    
    return YES;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    
    if ([self.delegate respondsToSelector:@selector(didScannedCodeString:)]) {
        for (AVMetadataMachineReadableCodeObject *code in metadataObjects) {
            NSString *stringValue = code.stringValue;
            [self.delegate didScannedCodeString:stringValue];
        }
    }
}


@end

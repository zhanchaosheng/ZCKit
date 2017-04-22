//
//  ZCBaseCameraController.h
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

FOUNDATION_EXPORT NSString * const ZCCameraErrorDomain;
FOUNDATION_EXPORT NSString *const ZCThumbnailCreatedNotification;

typedef NS_ENUM(NSInteger, ZCCameraErrorCode) {
    ZCCameraErrorFailedToAddInput = 98,
	ZCCameraErrorFailedToAddOutput,
};

@protocol ZCCameraControllerDelegate <NSObject>
- (void)deviceConfigurationFailedWithError:(NSError *)error;
- (void)mediaCaptureFailedWithError:(NSError *)error;
- (void)assetLibraryWriteFailedWithError:(NSError *)error;
@end

@interface ZCBaseCameraController : NSObject

@property (weak, nonatomic) id<ZCCameraControllerDelegate> delegate;
@property (nonatomic, strong, readonly) AVCaptureSession *captureSession;

// Session Configuration
- (BOOL)setupSession:(NSError **)error;
- (void)startSession;
- (void)stopSession;

// Override Hooks
- (BOOL)setupSessionInputs:(NSError **)error;
- (BOOL)setupSessionOutputs:(NSError **)error;
- (NSString *)sessionPreset;


// Camera Device Support
- (BOOL)switchCameras;
- (BOOL)canSwitchCameras;
@property (nonatomic, readonly) NSUInteger cameraCount;
@property (nonatomic, readonly) AVCaptureDevice *activeCamera;


// Still Image Capture
- (void)captureStillImage;

// Video Recording
- (void)startRecording;
- (void)stopRecording;
- (BOOL)isRecording;

@end

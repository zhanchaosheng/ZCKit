//
//  ZCCameraController.h
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ZCBaseCameraController.h"
#import "ZCCodeDetectionDelegate.h"


@interface ZCCameraController : ZCBaseCameraController

@property (weak, nonatomic) id <ZCCodeDetectionDelegate> codeDetectionDelegate;

@end

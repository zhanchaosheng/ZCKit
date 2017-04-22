//
//  ZCPreviewView.h
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ZCCodeDetectionDelegate.h"

@interface ZCPreviewView : UIView <ZCCodeDetectionDelegate>

@property (strong, nonatomic) AVCaptureSession *session;

@end

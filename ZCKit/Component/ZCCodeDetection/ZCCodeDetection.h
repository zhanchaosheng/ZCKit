//
//  ZCCodeDetection.h
//  ZCKit
//
//  Created by Cusen on 2017/4/23.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCCodeDetectionResultDelegate <NSObject>

- (void)didDetectCodesString:(NSString *)value;

@end

typedef void(^didDetectCodes) (NSString *value);

@interface ZCCodeDetection : NSObject
    
@property (nonatomic, weak) id<ZCCodeDetectionResultDelegate> delegate;

/// 获取预览视图
- (UIView *)getPreviewView;
    
/// 开始识别
- (void)startDetection;
    
/// 停止识别
- (void)stopDetection;
@end

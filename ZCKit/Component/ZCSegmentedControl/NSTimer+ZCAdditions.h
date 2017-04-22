//
//  NSTimer+ZCAdditions.h
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TimerFireBlock)(void);

@interface NSTimer (ZCAdditions)


/**
 Block方式触发的scheduledTimer

 @param inTimeInterval 触发间隔时长
 @param repeat 是否周期重复
 @param fireBlock 触发Block
 @return A new NSTimer object
 */
+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval
                           repeating:(BOOL)repeat
                              firing:(TimerFireBlock)fireBlock;

@end

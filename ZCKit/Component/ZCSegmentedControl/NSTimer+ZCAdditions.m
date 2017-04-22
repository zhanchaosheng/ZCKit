//
//  NSTimer+ZCAdditions.m
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import "NSTimer+ZCAdditions.h"

@implementation NSTimer (ZCAdditions)

+ (void)executeTimerBlock:(NSTimer *)timer {
    TimerFireBlock block = [timer userInfo];
    block();
}

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval
                           repeating:(BOOL)repeat
                              firing:(TimerFireBlock)fireBlock {
    id block = [fireBlock copy];
    return [self scheduledTimerWithTimeInterval:inTimeInterval
                                         target:self
                                       selector:@selector(executeTimerBlock:)
                                       userInfo:block
                                        repeats:repeat];
}

@end

//
//  ZCCodeDetectionDelegate.h
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

@protocol ZCCodeDetectionDelegate <NSObject>
- (void)didDetectCodes:(NSArray *)codes;
@end

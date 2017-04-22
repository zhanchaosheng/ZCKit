//
//  NSFileManager+ZCAdditions.h
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ZCAdditions)

- (NSString *)temporaryDirectoryWithTemplateString:(NSString *)templateString;

@end

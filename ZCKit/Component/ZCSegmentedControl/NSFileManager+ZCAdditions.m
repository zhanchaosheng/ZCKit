//
//  NSFileManager+ZCAdditions.m
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import "NSFileManager+ZCAdditions.h"

@implementation NSFileManager (ZCAdditions)

- (NSString *)temporaryDirectoryWithTemplateString:(NSString *)templateString {
    
    NSString *mkdTemplate =
    [NSTemporaryDirectory() stringByAppendingPathComponent:templateString];
    
    const char *templateCString = [mkdTemplate fileSystemRepresentation];
    char *buffer = (char *)malloc(strlen(templateCString) + 1);
    strcpy(buffer, templateCString);
    
    NSString *directoryPath = nil;
    
    char *result = mkdtemp(buffer);
    if (result) {
        directoryPath = [self stringWithFileSystemRepresentation:buffer
                                                          length:strlen(result)];
    }
    free(buffer);
    return directoryPath;
}

@end

//
//  ZCAssetsLibrary.h
//  ZCKit
//
//  Created by Cusen on 2017/4/22.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ZCAssetsLibraryWriteCompletionHandler)(BOOL success, NSError *error);

@interface ZCAssetsLibrary : NSObject

/// 将图片保存至相册，保存成功将发送ZCThumbnailCreatedNotification通知
- (void)writeImage:(UIImage *)image completionHandler:(ZCAssetsLibraryWriteCompletionHandler)completionHandler;

/// 将视频保存至相册，保存成功将生成第一帧图片并发送ZCThumbnailCreatedNotification通知
- (void)writeVideoAtURL:(NSURL *)videoURL completionHandler:(ZCAssetsLibraryWriteCompletionHandler)completionHandler;

@end

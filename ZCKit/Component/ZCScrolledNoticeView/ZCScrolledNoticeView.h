//
//  ZCScrolledNoticeView.h
//  ZCKit
//
//  Created by Cusen on 2017/5/7.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCScrolledNoticeView;
@protocol ZCScrolledNoticeViewDelegate <NSObject>
- (void)scrolledNoticeView:(ZCScrolledNoticeView *)view didSelected:(NSUInteger)index;
@end

@interface ZCScrolledNoticeView : UIView

@property (nonatomic, weak) id<ZCScrolledNoticeViewDelegate> delegate;
@property (nonatomic, strong) NSArray *texts;
@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, assign) CGFloat duration;

@end

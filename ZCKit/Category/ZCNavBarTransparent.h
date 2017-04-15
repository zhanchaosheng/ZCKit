//
//  ZCNavBarTransparent.h
//  ZCDemoUI
//
//  Created by Cusen on 2017/3/11.
//  Copyright © 2017年 zcs. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface ZCNavBarTransparent : NSObject
//
//@end


static const NSString *zcNavBarBgAlphaKey = @"navBarBgAlphaKey";
static const NSString *zcNavBarTintColorKey = @"navBarTintColorKey";

@interface UIViewController (ZCNavBarTransparent)
@property (nonatomic, assign) CGFloat navBarBgAlpha;
@property (nonatomic, strong) UIColor *navBarTintColor;
@end


@interface UINavigationController (ZCNavBarTransparent)
- (void)setNavigationBackgroundAlpha:(CGFloat)alpha;
@end

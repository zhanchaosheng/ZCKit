//
//  ZCNavBarTransparent.m
//  ZCDemoUI
//
//  Created by Cusen on 2017/3/11.
//  Copyright © 2017年 zcs. All rights reserved.
//

#import "ZCNavBarTransparent.h"
#import <objc/runtime.h>

//@implementation ZCNavBarTransparent
//
//@end


@implementation UIViewController (ZCNavBarTransparent)

- (CGFloat)navBarBgAlpha {
    CGFloat alpha = [objc_getAssociatedObject(self, &zcNavBarBgAlphaKey) floatValue];
    if (alpha > 1) {
        alpha = 1;
    }
    else if (alpha < 0) {
        alpha = 0;
    }
    return alpha;
}

- (void)setNavBarBgAlpha:(CGFloat)navBarBgAlpha {
    if (navBarBgAlpha > 1) {
        navBarBgAlpha = 1;
    }
    else if (navBarBgAlpha < 0) {
        navBarBgAlpha = 0;
    }
    objc_setAssociatedObject(self, &zcNavBarBgAlphaKey, @(navBarBgAlpha), OBJC_ASSOCIATION_ASSIGN);
    
    //update UI
    [self.navigationController setNavigationBackgroundAlpha:navBarBgAlpha];
}

- (UIColor *)navBarTintColor {
    UIColor *tintColor = objc_getAssociatedObject(self, &zcNavBarTintColorKey);
    return tintColor;
}

- (void)setNavBarTintColor:(UIColor *)navBarTintColor {
    self.navigationController.navigationBar.tintColor = navBarTintColor;
    objc_setAssociatedObject(self, &zcNavBarTintColorKey, navBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end



@implementation UINavigationController (ZCNavBarTransparent)

- (void)setNavigationBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = self.navigationBar.subviews[0];
    if (barBackgroundView) {
        UIView *shadowView = [barBackgroundView valueForKey:@"_shadowView"];
        if (shadowView && [shadowView isKindOfClass:[UIView class]]) {
            shadowView.alpha = alpha;
        }
        
        if (self.navigationBar.isTranslucent) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
                if (![self.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault]) {
                    UIView *backgroundEffectView = [barBackgroundView valueForKey:@"_backgroundEffectView"];
                    if (backgroundEffectView && [backgroundEffectView isKindOfClass:[UIView class]]) {
                        backgroundEffectView.alpha = alpha;
                        return;
                    }
                }
            }
            else {
                UIView *adaptiveBackdrop = [barBackgroundView valueForKey:@"_adaptiveBackdrop"];
                if (adaptiveBackdrop && [adaptiveBackdrop isKindOfClass:[UIView class]]) {
                    UIView *backdropEffectView = [barBackgroundView valueForKey:@"_backdropEffectView"];
                    if (backdropEffectView && [backdropEffectView isKindOfClass:[UIView class]]) {
                        backdropEffectView.alpha = alpha;
                        return;
                    }
                }
            }
        }
        
        barBackgroundView.alpha = alpha;
    }
}

@end

//
//  ZCSegmentedControl.h
//  ZCSegmentedControl
//
//  Created by cusen on 2017/3/10.
//  Copyright © 2016年 zcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCSegmentedControl;

@protocol ZCSegmentedControlDelegate <NSObject>

@optional
// segmented点击的时候调用，selectIndex：选中的index
- (void)segmentedValueDidChange:(ZCSegmentedControl *)segment selectIndex:(NSInteger)selectIndex;
// segmented点击的时候调用，selectIndex：选中的index，fromeIndex：从哪个index点过来的
- (void)segmentedValueDidChange:(ZCSegmentedControl *)segment selectIndex:(NSInteger)selectIndex fromeIndex:(NSInteger)fromeIndex;
// segmented点击的时候调用，selectIndex：选中的index，fromeIndex：从哪个index点过来的,selectButton:选中的button
- (void)segmentedValueDidChange:(ZCSegmentedControl *)segment selectIndex:(NSInteger)selectIndex fromeIndex:(NSInteger)fromeIndex selectButton:(UIButton *)selectButton;
// segmented点击的时候调用，selectIndex：选中的index，fromeIndex：从哪个index点过来的,selectButton:选中的button,allButtons:所有的button
- (void)segmentedValueDidChange:(ZCSegmentedControl *)segment selectIndex:(NSInteger)selectIndex fromeIndex:(NSInteger)fromeIndex selectButton:(UIButton *)selectButton allButtons:(NSArray *)allButtons;
@end

@interface ZCSegmentedControl : UIView

// 点击title的block回调
@property (nonatomic, copy) void(^tClick)(NSInteger index);
// 点击title的block回调,selectButton:选中的button
@property (nonatomic, copy) void(^titleClick)(NSInteger index, UIButton *selectButton);
// 所有title
@property (nonatomic, strong, readonly) NSArray *titles;
// 底部的滑块
@property (nonatomic, strong, readonly) UIView *sliderView;
// 辅助属性,当前选中的Button
@property (nonatomic, strong, readonly) UIButton *selectButton;
// button标题字体
@property (nonatomic, strong) UIFont *buttonTitleFont;
// 为选中的button颜色
@property (nonatomic, strong) UIColor *normalColor;
// 选中的button颜色
@property (nonatomic, strong) UIColor *selectColor;
// 滑块颜色
@property (nonatomic, strong) UIColor *sliderColor;
// 滑块高度
@property (nonatomic, assign) CGFloat sliderHeight;
// 边框颜色
@property (nonatomic, strong) UIColor *edgingColor;
// 边框宽度
@property (nonatomic, assign) CGFloat edgingWidth;
// delegate
@property (nonatomic, weak) id <ZCSegmentedControlDelegate> delegate;

/* 初始化方法 */
+ (instancetype)segmentWithFrame:(CGRect)frame titles:(NSArray *)titles tClick:(void(^)(NSInteger index))tClick;
/* 初始化方法，block回调中带有选中的button */
+ (instancetype)segmentWithFrame:(CGRect)frame titles:(NSArray *)titles titleClick:(void(^)(NSInteger index, UIButton *selectButton))titleClick;
/* 设置边框圆角 */
- (void)setBorderRadius:(CGFloat)radius;
/* 设置滑块的偏移量 */
- (void)setContentOffset:(CGPoint)contentOffset;
/* 设置文字颜色
 * normalColor:未选中的按钮文字颜色
 * selectColor:选中的按钮文字颜色
 */
- (void)setNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor;
/* 设置部分颜色
 * normalColor:未选中的按钮文字颜色
 * selectColor:选中的按钮文字颜色
 * edgingColor:边框颜色
 */
- (void)setNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor edgingColor:(UIColor *)edgingColor;
/* 设置所有颜色
 * normalColor:未选中的按钮文字颜色
 * selectColor:选中的按钮文字颜色
 * sliderColor:滑块背景颜色
 * edgingColor:边框颜色
 */
- (void)setNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor sliderColor:(UIColor *)sliderColor edgingColor:(UIColor *)edgingColor;
/* 设置所有属性
 * normalColor:未选中的按钮文字颜色
 * selectColor:选中的按钮文字颜色
 * sliderColor:滑块背景颜色
 * edgingColor:边框颜色
 * edgingWidth:边框宽度
 */
- (void)setNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor sliderColor:(UIColor *)sliderColor edgingColor:(UIColor *)edgingColor edgingWidth:(CGFloat)edgingWidth;
@end

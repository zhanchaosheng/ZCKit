//
//  ZCScrolledNoticeView.m
//  ZCKit
//
//  Created by Cusen on 2017/5/7.
//  Copyright © 2017年 Zcoder. All rights reserved.
//

#import "ZCScrolledNoticeView.h"

#define TopSpace 10
#define LeftSpace 20

@interface ZCScrolledNoticeView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *textLabelArray;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, assign) NSUInteger nextIndex;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ZCScrolledNoticeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = 0;
        _duration = 3.0f;
        [self initView];
    }
    return self;
}

- (void)layoutSubviews {
    self.leftView.frame = [self getLeftViewRect];
    self.scrollView.frame = [self getScrollViewRect];
    [self reLoadScrollViewContents];
}

- (void)dealloc {
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
}

- (void)setTexts:(NSArray *)texts {
    _texts = [texts copy];
    [self setNeedsLayout];
}

- (NSMutableArray *)textLabelArray {
    if (_textLabelArray == nil) {
        _textLabelArray = [NSMutableArray array];
    }
    return _textLabelArray;
}

- (NSUInteger)nextIndex {
    return (_currentIndex + 1) % self.texts.count;
}

- (void)initView {
    _leftView = [[UIImageView alloc] init];
    [self addSubview:_leftView];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.scrollEnabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(tapHandle:)];
    [_scrollView addGestureRecognizer:tap];
    [self addSubview:_scrollView];
}

- (CGRect)getLeftViewRect {
    CGFloat width = self.bounds.size.height - TopSpace * 2;
    return CGRectMake(LeftSpace, TopSpace, width, width);
}

- (CGRect)getScrollViewRect {
    CGFloat leftViewWidth = self.bounds.size.height - TopSpace * 2;
    CGFloat left = LeftSpace + leftViewWidth + 10;
    return CGRectMake(left, 0, self.bounds.size.width - left, self.bounds.size.height);
}

- (void)reLoadScrollViewContents {
    NSUInteger count = 0;
    if (self.texts) {
        count = self.texts.count;
    }
    if (count <= 0) {
        return;
    }
    
    [self.timer invalidate];
    [self.textLabelArray removeAllObjects];
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    CGRect scrollViewRect = self.scrollView.bounds;
    
    count = count >= 2 ? 2 : 1;
    for (int i = 0; i < count; i++) {
        CGRect rect = CGRectMake(0,
                                 i * scrollViewRect.size.height,
                                 scrollViewRect.size.width,
                                 scrollViewRect.size.height);
        UILabel *textLabel = [[UILabel alloc] initWithFrame:rect];
        textLabel.text = self.texts[i];
        [self.textLabelArray addObject:textLabel];
        [self.scrollView addSubview:textLabel];
    }
    self.scrollView.contentSize = CGSizeMake(scrollViewRect.size.width,
                                             scrollViewRect.size.height * count);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.currentIndex = 0;
    __weak __typeof__(self)weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong __typeof__(weakSelf)strongSelf = weakSelf;
        [strongSelf scrollUp];
    }];
}

- (void)scrollUp {
    UILabel *textLabel = self.textLabelArray[1];
    CGRect scrollRect = textLabel.frame;
    [self.scrollView scrollRectToVisible:scrollRect animated:YES];
    self.currentIndex = self.nextIndex;
    [self performSelector:@selector(reset) withObject:nil afterDelay:1.0];
}

- (void)reset {
    UILabel *textLabel_0 = self.textLabelArray[0];
    UILabel *textLabel_1 = self.textLabelArray[1];
    [self.scrollView scrollRectToVisible:textLabel_0.frame animated:NO];
    textLabel_0.text = textLabel_1.text;
    textLabel_1.text = self.texts[self.nextIndex];
}

- (void)tapHandle:(UIGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(scrolledNoticeView:didSelected:)]) {
        [self.delegate scrolledNoticeView:self didSelected:self.currentIndex];
    }
}

@end

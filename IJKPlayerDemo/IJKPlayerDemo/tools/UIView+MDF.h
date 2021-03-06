//
//  UIView+MDF.h
//  RoyalClient
//
//  Created by Dick on 2017/10/9.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MDFGestureRecognizerActionBlock)(UIGestureRecognizer *gestureRecognizer);

@interface UIView (MDF)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat cx;
@property (nonatomic, assign) CGFloat cy;
@property (nonatomic, assign) CGSize size;

// 截图
- (UIImage *)mdf_screenshot;

// 递归log view的subviews的信息
- (void)mdf_logSubviewsInfo;

// 递归遍历view的subviews
- (void)mdf_recursiveEnumerateViewsUsingBlock:(void (^)(UIView *subView, UIView* superView, BOOL *stop))block;

// 返回view中的first responder
- (UIView *)mdf_firstResponder;

// 复制view
- (UIView *)mdf_copy;

// single tapped
- (void)mdf_whenSingleTapped:(MDFGestureRecognizerActionBlock )block;

// double tapped
- (void)mdf_whenDoubleTapped:(MDFGestureRecognizerActionBlock )block;

// long pressed
- (void)mdf_whenLongPressed:(MDFGestureRecognizerActionBlock )block;

// 返回动画的缓动类型
+ (UIViewAnimationOptions)mdf_animationOptionsWithCurve:(UIViewAnimationCurve)curve;

// 在不改变view的frame的同时来设置anchor point
- (void)mdf_setAnchorPoint:(CGPoint)anchorPoint;


@end

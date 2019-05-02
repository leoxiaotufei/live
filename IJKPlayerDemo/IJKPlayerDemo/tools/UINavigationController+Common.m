//
//  UINavigationController+Common.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/29.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "UINavigationController+Common.h"

@implementation UINavigationController (Common)
- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    // 导航栏背景透明度设置
    UIView *barBackgroundView = [self.navigationBar subviews].firstObject;// _UIBarBackground
    UIImageView *backgroundImageView = [barBackgroundView subviews].firstObject;// UIImageView
    
    if (self.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            backgroundImageView.alpha = alpha;
        }else {
            if (barBackgroundView.subviews.count > 1) {
                UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
                if (backgroundEffectView != nil) {
                    backgroundEffectView.alpha = alpha;
                }
            }

        }
    } else {
        barBackgroundView.alpha = alpha;
    }

}
@end

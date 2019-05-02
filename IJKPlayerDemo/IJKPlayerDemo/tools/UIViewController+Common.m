//
//  UIViewController+Common.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/29.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "UIViewController+Common.h"
#import <objc/runtime.h>
#import "UINavigationController+Common.h"
static char *CloudoxKey = "CloudoxKey";

@implementation UIViewController (Common)

- (void)setNavBarBgAlpha:(NSString *)navBarBgAlpha {
    objc_setAssociatedObject(self, CloudoxKey, navBarBgAlpha, OBJC_ASSOCIATION_COPY_NONATOMIC);
    // 设置导航栏透明度（利用Category自己添加的方法）
    [self.navigationController setNeedsNavigationBackground:[navBarBgAlpha floatValue]];

}

-(NSString *)navBarBgAlpha{
    return objc_getAssociatedObject(self, CloudoxKey);
}

@end

//
//  LiveCommon.h
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/30.
//  Copyright © 2019 eirc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveCommon : NSObject

/**
 获取相机权限

 @return 是否开启权限
 */
+ (BOOL)getCamareLimits;


/**
 检查麦克风权限

 @return 是否开启
 */
+ (BOOL)checkAudioStatus;
@end

NS_ASSUME_NONNULL_END

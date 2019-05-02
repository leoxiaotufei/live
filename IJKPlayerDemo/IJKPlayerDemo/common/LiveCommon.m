//
//  LiveCommon.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/30.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "LiveCommon.h"
#import <AVFoundation/AVFoundation.h>

@implementation LiveCommon

+ (BOOL)getCamareLimits {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //用户是否允许摄像头使用
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authorizationStatus == AVAuthorizationStatusRestricted || authorizationStatus == AVAuthorizationStatusDenied) {
            [SVProgressHUD showInfoWithStatus:@"摄像头访问受限, 请前往设置"];
            return NO;
        }
        return YES;
    }
    
    [SVProgressHUD showInfoWithStatus:@"摄像头不可用, 请检查手机摄像头设备"];

    return NO;
}

+ (BOOL)checkAudioStatus {
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authorizationStatus == AVAuthorizationStatusRestricted || authorizationStatus == AVAuthorizationStatusDenied) {
        [SVProgressHUD showInfoWithStatus:@"麦克风未授权"];
        return NO;
    }
    return YES;
}
@end

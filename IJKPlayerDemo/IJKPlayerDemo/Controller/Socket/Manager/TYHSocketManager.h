//
//  TYHSocketManager.h
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/29.
//  Copyright © 2019 eirc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYHSocketManager : NSObject
+ (instancetype)share;

- (BOOL)connect;
- (void)disConnect;

- (void)sendMsg:(NSString *)msg;
- (void)pullTheMsg;
@end

NS_ASSUME_NONNULL_END

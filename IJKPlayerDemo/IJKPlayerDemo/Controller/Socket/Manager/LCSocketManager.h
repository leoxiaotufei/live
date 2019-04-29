//
//  LCSocketManager.h
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/11.
//  Copyright © 2019 eirc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LCSocketManager : NSObject

+ (instancetype)share;

- (void)connect;

- (void)disConnect;

- (void)sendMsg:(NSString *)msg;

@end


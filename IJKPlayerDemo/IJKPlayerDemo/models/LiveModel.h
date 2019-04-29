//
//  LiveModel.h
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/10.
//  Copyright © 2019 eirc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Creator : NSObject
@property (nonatomic, copy) NSString *portrait;
@property (nonatomic, copy) NSString *current_value;
@property (nonatomic, copy) NSString *hometown;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *next_diff;
@property (nonatomic, copy) NSString *nick;

@end

@interface LiveInfo : NSObject

@property (nonatomic, copy) NSString  *name;
@property (nonatomic, copy) NSString *share_addr;
@property (nonatomic, copy) NSString *stream_addr;
@property (nonatomic, strong) Creator *creator;
@end

@interface LiveData : NSObject
@property (nonatomic, strong) LiveInfo *live_info;
@property (nonatomic, assign) NSInteger score;
@end

@interface LiveModel : NSObject

@property (nonatomic, strong) LiveData *data;

@end


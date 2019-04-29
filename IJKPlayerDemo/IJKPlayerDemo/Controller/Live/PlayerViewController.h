//
//  PlayerViewController.h
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/10.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "BaseViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface PlayerViewController : BaseViewController
@property (nonatomic, copy) NSString *playerUrl;
@property (nonatomic, strong) IJKFFMoviePlayerController *playerVC;

- (void)setupPlayerVC;
@end


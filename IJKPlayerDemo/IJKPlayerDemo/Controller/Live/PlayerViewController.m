//
//  PlayerViewController.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/10.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "PlayerViewController.h"
#import "UIImage+MDF.h"
#import "UIViewController+Common.h"
@interface PlayerViewController ()
@end

@implementation PlayerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent=true;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupPlayerVC];
}

- (void)setupPlayerVC {
    NSURL *url = [NSURL URLWithString:self.playerUrl];
    //创建IJFFMoviePlayerController 专门用来直播,春如拉流地址就好
    IJKFFMoviePlayerController *playerVC = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    //准备播放
    [playerVC prepareToPlay];
    //强引用, 防止被销毁
    _playerVC = playerVC;
    playerVC.view.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:playerVC.view atIndex:1];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.shadowImage = [UIImage alloc];


    [_playerVC pause];
    [_playerVC stop];
}

@end

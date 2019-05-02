//
//  CatPlayerViewController.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/13.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "CatPlayerViewController.h"
#import "ALinLive.h"
#import "UIViewController+Common.h"
@interface CatPlayerViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *liveInfoView;
@end

@implementation CatPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
//    [self setupPlayerVC];
    if (@available(iOS 11.0, *)) {
        self.view.insetsLayoutMarginsFromSafeArea = false;
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setupPlayerVC {
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.playerUrl withOptions:options];

    // 填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    moviePlayer.shouldAutoplay = NO;
    // 默认不显示
    moviePlayer.shouldShowHudView = NO;
    moviePlayer.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [moviePlayer.view addSubview:self.liveInfoView];
    [self.scrollView insertSubview:moviePlayer.view atIndex:1];

    self.playerVC = moviePlayer;

    [moviePlayer prepareToPlay];

    //设置监听
    [self initObserver];
//     显示工会其他主播和类似主播
//    [moviePlayer.view bringSubviewToFront:self.otherView];
//
//     开始来访动画
//    [self.emitterLayer setHidden:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@", NSStringFromClass(scrollView.class));
}

- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.playerVC];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.playerVC];
}

#pragma mark - notify method

- (void)stateDidChange
{
    if ((self.playerVC.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.playerVC.isPlaying) {
            [self.playerVC play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (_placeHolderView) {
//                    [_placeHolderView removeFromSuperview];
//                    _placeHolderView = nil;
//                    [self.moviePlayer.view addSubview:_renderer.view];
//                }
//                [self.parentVc hideGufLoding];
            });
        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
//            if (self.parentVc.gifView.isAnimating) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.parentVc hideGufLoding];
//                });
//
//            }jj
        }
    }else if (self.playerVC.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
//        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
    }
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.playerVC.loadState, self.playerVC.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
//    if (self.playerVC.loadState & IJKMPMovieLoadStateStalled && !self.parentVc.gifView) {
//        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
//        return;
//    }
    //    方法：
    //      1、重新获取直播地址，服务端控制是否有地址返回。
    //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
//    __weak typeof(self)weakSelf = self;
//    [[ALinNetworkTool shareTool] GET:self.live.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功%@, 等待继续播放", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
//        [weakSelf.moviePlayer shutdown];
//        [weakSelf.moviePlayer.view removeFromSuperview];
//        weakSelf.moviePlayer = nil;
//        weakSelf.endView.hidden = NO;
//    }];
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.scrollEnabled = YES;
        _scrollView.contentSize = CGSizeMake(KScreenWidth,2 * KScreenHeight);
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}


- (UIScrollView *)liveInfoView {
    if (!_liveInfoView) {
        _liveInfoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,  KScreenWidth, KScreenHeight)];
        _liveInfoView.backgroundColor = [UIColor clearColor];
        _liveInfoView.pagingEnabled = YES;
        _liveInfoView.contentSize = CGSizeMake(2 * KScreenWidth, KScreenHeight);
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight)];
        redView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_liveInfoView addSubview:redView];
        _liveInfoView.contentOffset = CGPointMake(KScreenWidth, 0);
        _liveInfoView.bounces = NO;
    }
    return _liveInfoView;
}

@end

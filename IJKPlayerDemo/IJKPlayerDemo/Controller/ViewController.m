//
//  ViewController.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/10.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "ViewController.h"
#import "PlayerViewController.h"
#import "LiveCollectionViewCell.h"
#import "LiveModel.h"

#define LIVE_URL @"https://service.inke.cn/api/live/card_recommend?user_level=2&req_type=1"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray <LiveModel *>*dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播";
    self.dataArray = [NSArray array];
    [self.view addSubview:self.collectionView];
    [self loadData];
}

- (void)loadData {
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    mager.responseSerializer = [AFJSONResponseSerializer serializer];
    mager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    mager.requestSerializer.timeoutInterval = 15;
    [SVProgressHUD show];
    [mager GET:LIVE_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld",downloadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.dataArray = [LiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"cards"]];
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.domain);
        [SVProgressHUD showErrorWithStatus:error.domain];
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LiveCollectionViewCell class]) forIndexPath:indexPath];
    LiveModel *liveModel = self.dataArray[indexPath.item];
    cell.liveModel = liveModel;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayerViewController *player = [[PlayerViewController alloc] init];
    LiveModel *liveModel = self.dataArray[indexPath.row];
    player.playerUrl = liveModel.data.live_info.stream_addr;
    [self.navigationController pushViewController:player animated:YES];
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0 , 10, 0, 10);
        layout.itemSize = CGSizeMake((KScreenWidth - 30)/2, (KScreenWidth - 30)/2);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];;
        [_collectionView registerClass:[LiveCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LiveCollectionViewCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}


@end

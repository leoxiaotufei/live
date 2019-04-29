//
//  CatLiveListViewController.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/13.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "CatLiveListViewController.h"
#import "ALinUser.h"
#import "LiveCollectionViewCell.h"
#import "PlayerViewController.h"
#import "CatPlayerViewController.h"
@interface CatLiveListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) AFHTTPSessionManager *mamager;

/** 最新主播列表 */
@property(nonatomic, strong) NSMutableArray <ALinUser *>*anchors;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CatLiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)refreshData {
    self.currentPage = 1;
    [self.anchors removeAllObjects];
    [self getAnchorsList];
}

- (void)loadMoreData {
    self.currentPage++;
    [self getAnchorsList];
}

- (void)getAnchorsList {
   
    __weak typeof(self)weakSelf = self;
    [self.mamager GET:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld",_currentPage] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *statuMsg = responseObject[@"msg"];
        if ([statuMsg isEqualToString:@"fail"]) { // 数据已经加载完毕, 没有更多数据了
            [SVProgressHUD showInfoWithStatus:@"暂无更多最新数据"];
            self.currentPage --;
        }else {
            NSArray *result = [ALinUser mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (result.count > 0) {
                [weakSelf.anchors addObjectsFromArray:result];
            }
            [self.collectionView reloadData];
        }
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        weakSelf.currentPage--;
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
    }];
}

- (AFHTTPSessionManager *)mamager {
    if (!_mamager) {
        _mamager = [AFHTTPSessionManager manager];
        _mamager.responseSerializer = [AFJSONResponseSerializer serializer];
        _mamager.requestSerializer.timeoutInterval =  15.0;
        _mamager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    }
    
    return _mamager;
}
- (NSMutableArray<ALinUser *> *)anchors {
    if (!_anchors) {
        _anchors = [NSMutableArray array];
    }
    return _anchors;
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
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.anchors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LiveCollectionViewCell class]) forIndexPath:indexPath];
    cell.alinUser = self.anchors[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CatPlayerViewController *player = [[CatPlayerViewController alloc] init];
    ALinUser *user = self.anchors[indexPath.item];
    player.playerUrl = user.flv;
    [self.navigationController pushViewController:player animated:YES];
}

@end

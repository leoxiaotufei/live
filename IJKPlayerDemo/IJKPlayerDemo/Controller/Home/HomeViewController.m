//
//  HomeViewController.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/11.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "HomeViewController.h"
#import "LiveListViewController.h"
#import "SocketViewController.h"
#import "CatLiveListViewController.h"
#import "ShowTimeViewController.h"
#import "GPUImageViewController.h"
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *vcArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        BaseViewController *vc = [[NSClassFromString(self.vcArray[indexPath.row]) alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 0.0;
        _tableView.estimatedSectionFooterHeight = 0.0;
        _tableView.estimatedSectionHeaderHeight = 0.0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}


- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[@"LiveListViewController",@"CatLiveListViewController",@"ShowTimeViewController",@"SocketViewController",@"GPUImageViewController",@"GPUImagePicViewController",@"GPUImageStudyListVC"];
    }
    
    return _vcArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"映客直播",@"猫播",@"推流",@"scoketDemo",@"视频美颜滤镜",@"美图滤镜",@"GPUImage练习"];
    }
    
    return _titleArray;
}

@end

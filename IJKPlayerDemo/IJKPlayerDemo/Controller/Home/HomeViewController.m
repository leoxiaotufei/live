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
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
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
    if (indexPath.row == 0) {
        LiveListViewController *live = [[LiveListViewController alloc] init];
        [self.navigationController pushViewController:live animated:YES];
    }else if (indexPath.row == 1) {
        CatLiveListViewController *cat = [[CatLiveListViewController alloc] init];
        [self.navigationController pushViewController:cat animated:YES];
    }else if (indexPath.row == 2) {
        ShowTimeViewController *showTime = [[ShowTimeViewController alloc] init];
        [self.navigationController pushViewController:showTime animated:YES];
    }else if (indexPath.row == 3) {
        SocketViewController *socketVC = [[SocketViewController alloc] init];
        [self.navigationController pushViewController:socketVC animated:YES];
    }
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

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"映客直播",@"猫播",@"推流",@"scoketDemo"];
    }
    
    return _titleArray;
}

@end

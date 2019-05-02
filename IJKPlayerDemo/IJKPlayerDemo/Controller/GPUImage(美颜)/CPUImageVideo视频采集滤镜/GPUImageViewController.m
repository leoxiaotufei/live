//
//  GPUImageViewController.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/30.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "GPUImageViewController.h"
#import "GPUImageFilterViewController.h"
#import "BeautifyFilterViewController.h"

@interface GPUImageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *vcArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation GPUImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vcArray = @[@"GPUImageFilterViewController",@"BeautifyFilterViewController"];
    self.titleArray = @[@"GPUImage原生美颜",@"利用美颜滤镜美颜"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    BaseViewController *vc = [[NSClassFromString(self.vcArray[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

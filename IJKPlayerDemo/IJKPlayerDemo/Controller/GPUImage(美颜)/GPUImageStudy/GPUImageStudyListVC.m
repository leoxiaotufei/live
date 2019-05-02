//
//  GPUImageStudyListVC.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/30.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "GPUImageStudyListVC.h"

@interface GPUImageStudyListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation GPUImageStudyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray =[NSMutableArray array];
    for (NSInteger i = 0; i < 1; i++) {
        NSString *str = [NSString stringWithFormat:@"GPUImageDemo%ld",i+1];
        [_titleArray addObject:str];
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    cell.textLabel.text = self.titleArray[indexPath.item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    BaseViewController *vc = [[NSClassFromString(self.titleArray[indexPath.row]) alloc] init];
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

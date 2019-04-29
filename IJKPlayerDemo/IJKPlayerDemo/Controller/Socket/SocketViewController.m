//
//  SocketViewController.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/11.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "SocketViewController.h"
#import "LCSocketManager.h"
#import "TYHSocketManager.h"
@interface SocketViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) TYHSocketManager *manager;
@end

@implementation SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [TYHSocketManager share];
    
    _textField = [UITextField new];
    _textField.borderStyle = UITextBorderStyleLine;
    _textField.placeholder = @"请输入消息";
    [self.view addSubview:_textField];
    
    UIButton *send = [self creatButtonWithTitle:@"发送" andBackColor:[UIColor redColor] andSelector:@selector(sender)];
    UIButton *connect = [self creatButtonWithTitle:@"连接" andBackColor:[UIColor blueColor] andSelector:@selector(connect)];
    UIButton *disConnect = [self creatButtonWithTitle:@"断开连接" andBackColor:[UIColor blueColor] andSelector:@selector(disConnect)];
    [self.view addSubview:send];
    [self.view addSubview:connect];
    [self.view addSubview:disConnect];
    
    //    __weak typeof(self) weakSelf = self;
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.top.equalTo(self.view).mas_equalTo(100);
    }];
    
    [send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textField);
        make.top.equalTo(self.textField.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    [connect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(send);
        make.top.equalTo(send.mas_bottom).offset(20);
    }];
    [disConnect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(connect);
        make.top.equalTo(connect.mas_bottom).mas_equalTo(20);
    }];
}


- (UIButton *)creatButtonWithTitle:(NSString *)title andBackColor:(UIColor *)color andSelector:(SEL)selector {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = color;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

//发送
- (void)sender {
    if (!_textField.text || _textField.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入消息"];
        return;
    }
    [_manager sendMsg:_textField.text];
}

//连接

- (void)connect {
    BOOL isSuccess = [_manager connect];
    if (isSuccess) {
        [SVProgressHUD showSuccessWithStatus:@"连接成功"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"连接失败"];
        
    }
}

- (void)disConnect {
    [_manager disConnect];
    
}



@end

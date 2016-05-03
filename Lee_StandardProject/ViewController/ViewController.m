//
//  ViewController.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/2/25.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "ViewController.h"
#import "ReigsterViewController.h"
#import "LoginViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIButton *registerBtn;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIImageView *iconImg;
@end

@implementation ViewController
#pragma mark - 方法 Methods
- (void)goToRegisterViewController:(UIButton *)sender {
    ReigsterViewController *vc = [ReigsterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goToLoginViewController:(UIButton *)sender {
    LoginViewController *vc = [LoginViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self iconImg];
    [self registerBtn];
    [self loginBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 懒加载 Lazy Load
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"an"]];
        [self.view addSubview:_iconImg];
        _iconImg.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 100);
        
    }
    return _iconImg;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.textColor = [UIColor whiteColor];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:30];
        
        [_registerBtn setBackgroundImage:[UIImage imageNamed:@"btn_orange_nor"] forState:UIControlStateNormal];
        [_registerBtn setBackgroundImage:[UIImage imageNamed:@"btn_orange_press"] forState:UIControlStateHighlighted];
        [self.view addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.iconImg.mas_bottom).equalTo(60);
            make.width.equalTo(160);
            make.height.equalTo(40);
        }];
        
        [_registerBtn addTarget:self action:@selector(goToRegisterViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setFont:[UIFont systemFontOfSize:30]];
        
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_orange_nor"] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_orange_press"] forState:UIControlStateHighlighted];
        [self.view addSubview:_loginBtn];
        _loginBtn.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.iconImg, 150)
        .widthIs(160)
        .heightIs(40);
        
        [_loginBtn addTarget:self action:@selector(goToLoginViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
@end

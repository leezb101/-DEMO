//
//  ReigsterViewController.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/25.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "ReigsterViewController.h"
#import "TextCell.h"
#import "ButtonCell.h"

@interface ReigsterViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic,strong) UITableView *registerTableView;
@end

@implementation ReigsterViewController
#pragma mark - UITextFieldDelegate

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TextCell *cell = [TextCell new];
        if (indexPath.row == 0) {
            cell.label.text = @"用户名";
            cell.textField.placeholder = @"请输入要注册的用户名";
            cell.tag = 1000;
        }else if (indexPath.row == 1){
            cell.label.text = @"密码";
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder = @"请输入要使用的密码";
            cell.tag = 2000;
        }else {
            cell.label.text = @"验证密码";
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder = @"请再次输入密码";
            cell.tag = 3000;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        ButtonCell *cell = [ButtonCell new];
        [cell okBtn];
        [cell.okBtn addTarget:self action:@selector(registerOKAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)registerOKAction:(UIButton *)sender {
    TextCell *usrNameCell = [self.registerTableView viewWithTag:1000];
    TextCell *pwdCell = [self.registerTableView viewWithTag:2000];
    TextCell *confirmCell = [self.registerTableView viewWithTag:3000];

    NSString *accontsPath = kAccontsPath;
    NSLog(@"%@", accontsPath);
    NSMutableDictionary *accountsDic = [[NSMutableDictionary alloc] initWithContentsOfFile:accontsPath];
    NSMutableArray *userNames = [[accountsDic allKeys] mutableCopy];
    NSLog(@"%@", userNames);
    
    if ([userNames containsObject:usrNameCell.textField.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该用户名已被使用, 请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }else {
        if (usrNameCell.textField.text.length < 8 || usrNameCell.textField.text.length > 20) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的用户名,用户名长度为8-20字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }else if (pwdCell.textField.text.length < 6) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入长度不小于6个字符的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }else if (![confirmCell.textField.text isEqualToString:pwdCell.textField.text]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请确保两次输入的密码完全一致,区分大小写" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"您已注册成功!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];

            [accountsDic setObject:pwdCell.textField.text forKey:[usrNameCell.textField.text lowercaseString]];
            [accountsDic writeToFile:kAccontsPath atomically:YES];
            
        }
    }
}

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self registerTableView];
    [((TextCell *)[self.registerTableView viewWithTag:1000]).textField becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载 Lazy Load
- (UITableView *)registerTableView {
    if (!_registerTableView) {
        _registerTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _registerTableView.delegate = self;
        _registerTableView.dataSource = self;
        _registerTableView.allowsSelection = NO;
        
        [self.view addSubview:_registerTableView];
        _registerTableView.sd_layout
        .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return _registerTableView;
}

@end

//
//  LoginViewController.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/25.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "LoginViewController.h"
#import "TextCell.h"
#import "ButtonCell.h"
#import "DetailViewController.h"

@interface LoginViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *loginTableView;
@end

@implementation LoginViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
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
            cell.textField.placeholder = @"请输入您的用户名";
            cell.tag = 1000;
        }else if (indexPath.row == 1) {
            cell.label.text = @"密码";
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder = @"请输入您的密码";
            cell.tag = 2000;
        }
        return cell;
    }else if (indexPath.section == 1) {
        ButtonCell *cell = [ButtonCell new];
        [cell okBtn];
        [cell.okBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

#pragma mark - 方法 Methods
- (void)loginAction:(UIButton *)sender {
    TextCell *usrNameCell = [self.loginTableView viewWithTag:1000];
    TextCell *pwdCell = [self.loginTableView viewWithTag:2000];
    
    NSString *accountsPath = kAccontsPath;
    NSDictionary *accountsDic = [[NSDictionary alloc] initWithContentsOfFile:accountsPath];
    NSString *keyName = [usrNameCell.textField.text lowercaseString];
    
    NSArray *usrNames = [accountsDic allKeys];
    if (![usrNames containsObject:keyName]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"该用户名不存在,请确认您的用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else if (![[accountsDic valueForKey:keyName] isEqualToString:pwdCell.textField.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"输入的用户名或密码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    }else if ([[accountsDic valueForKey:keyName] isEqualToString:pwdCell.textField.text]) {
        DetailViewController *vc = [[DetailViewController alloc] initWithKeyName:keyName];
        [self.navigationController pushViewController:vc animated:YES];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSString *usrPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:keyName];
            [[NSFileManager defaultManager] createDirectoryAtPath:usrPath withIntermediateDirectories:YES attributes:nil error:nil];
            NSLog(@"Login VC usrPath :%@", usrPath);
            
            NSString *currentAccountPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"CurrentAccount.plist"];
            NSArray *currentUsr = @[keyName];
            [currentUsr writeToFile:currentAccountPath atomically:YES];
        });
    }
}

#pragma mark - 生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self loginTableView];
    [((TextCell *)[self.loginTableView viewWithTag:1000]).textField becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载 Lazy Load
- (UITableView *)loginTableView {
    if (!_loginTableView) {
        _loginTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _loginTableView.delegate = self;
        _loginTableView.dataSource = self;
        [self.view addSubview:_loginTableView];
        _loginTableView.sd_layout
        .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return _loginTableView;
}

@end

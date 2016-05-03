//
//  PostViewController.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/28.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()
@property (nonatomic,strong) UITextField *titleTF;
@property (nonatomic,strong) UITextView *contentTV;
@property (nonatomic,strong) UIBarButtonItem *confirmBtn;
@end

@implementation PostViewController
- (id)initwithKeyName:(NSString *)keyName {
    if (self == [super init]) {
        self.keyName = keyName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.confirmBtn;
    [self titleTF];
    [self contentTV];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextField *)titleTF {
    if (!_titleTF) {
        _titleTF = [UITextField new];
        _titleTF.textColor = [UIColor colorWithRed:0.3845 green:0.4944 blue:1.0 alpha:1.0];
        _titleTF.placeholder = @"请输入文章标题";
        _titleTF.layer.cornerRadius = 5;
        _titleTF.layer.borderWidth = 2;
        _titleTF.layer.borderColor = [UIColor purpleColor].CGColor;
        _titleTF.backgroundColor = [UIColor colorWithRed:0.7676 green:0.7986 blue:0.808 alpha:1.0];
        _titleTF.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:_titleTF];
        _titleTF.sd_layout
        .topSpaceToView(self.view, 30)
        .leftSpaceToView(self.view, 20)
        .rightSpaceToView(self.view, 20)
        .heightIs(35);
    }
    return _titleTF;
}

- (UITextView *)contentTV {
    if (!_contentTV) {
        _contentTV = [UITextView new];
        _contentTV.textColor = [UIColor blackColor];
        _contentTV.font = [UIFont systemFontOfSize:20];
        _contentTV.allowsEditingTextAttributes = YES;
        _contentTV.backgroundColor = [UIColor colorWithRed:0.7676 green:0.7986 blue:0.808 alpha:1.0];
        _contentTV.layer.cornerRadius = 5;
        _contentTV.layer.borderWidth = 2;
        _contentTV.layer.borderColor = [UIColor purpleColor].CGColor;
        [self.view addSubview:_contentTV];
        _contentTV.sd_layout
        .topSpaceToView(self.titleTF, 15)
        .leftEqualToView(self.titleTF)
        .rightEqualToView(self.titleTF)
        .bottomSpaceToView(self.view, 30);
    }
    return _contentTV;
}

- (UIBarButtonItem *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(confirmAction:)];
    }
    return _confirmBtn;
}

- (void)confirmAction:(id)sender {
    NSString *fileName = [NSString stringWithFormat:@"%@/Articles.plist", self.keyName];
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:fileName];
    NSMutableDictionary *rootDic = [NSMutableDictionary dictionaryWithContentsOfFile:Path];
    NSMutableArray *titleArr = rootDic[@"titles"];
    NSMutableArray *contentArr = rootDic[@"contents"];
    
    [titleArr addObject:self.titleTF.text];
    [contentArr addObject:self.contentTV.text];
    
    [rootDic setObject:titleArr forKey:@"titles"];
    [rootDic setObject:contentArr forKey:@"contents"];
    [rootDic writeToFile:Path atomically:YES];
    NSLog(@"%@", Path);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

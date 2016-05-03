//
//  DetailViewController.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/25.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "DetailViewController.h"
#import "ArticleCell.h"
#import "PostViewController.h"
#import "ArticleViewController.h"
#import "ViewController.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,copy) NSMutableDictionary *dataList;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIBarButtonItem *postBtn;
@property (nonatomic,strong) UIBarButtonItem *resignBtn;
@end

@implementation DetailViewController
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSMutableArray *)self.dataList[@"titles"]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCell *cell = [ArticleCell cellWithTableView:tableView];
    if (((NSArray *)self.dataList[@"titles"]).count == 0) {
        return cell;
    }
    cell.titleLabel.text = self.dataList[@"titles"][indexPath.row];
    
//    if (((NSString *)self.dataList[@"contents"][indexPath.row]).length > 100) {
//            cell.contentTV.text = [(NSString *)self.dataList[@"contents"][indexPath.row] substringToIndex:100];
//    }else {
//        cell.contentTV.text = self.dataList[@"contents"][indexPath.row];
//    }
    return cell;
}

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width
{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:width tableView:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.dataList[@"titles"][indexPath.row];
    NSString *content = self.dataList[@"contents"][indexPath.row];
    ArticleViewController *vc = [[ArticleViewController alloc] initWithArticleTitle:title articleContent:content];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //先删数据, 再删UI
        [_dataList[@"titles"] removeObjectAtIndex:indexPath.row];
        [_dataList[@"contents"] removeObjectAtIndex:indexPath.row];
        NSString *fileName = [NSString stringWithFormat:@"%@/Articles.plist", self.keyName];
        NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:fileName];
        
        [_dataList writeToFile:Path atomically:YES];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    return @[deleteAction];
}

#pragma mark - 生命周期 Life Circle
- (instancetype)initWithKeyName:(NSString *)keyName {
    if (self = [super init]) {
        self.keyName = keyName;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.postBtn;
    self.navigationItem.leftBarButtonItem = self.resignBtn;
    WK(weakSelf);
    [self.tableView addHeaderRefresh:^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView endHeaderRefresh];
    }];
    [self.tableView beginHeaderRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)dataList {
    NSString *fileName = [NSString stringWithFormat:@"%@/Articles.plist", self.keyName];
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:fileName];
    NSLog(@"path in DetailVC :%@", Path);
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:Path]) {
        _dataList = [NSMutableDictionary new];
        NSMutableArray *titleArr = [NSMutableArray new];
        NSMutableArray *contentArr = [NSMutableArray new];
        [_dataList setObject:titleArr forKey:@"titles"];
        [_dataList setObject:contentArr forKey:@"contents"];
        [_dataList writeToFile:Path atomically:YES];

    }else {
        _dataList = [NSMutableDictionary dictionaryWithContentsOfFile:Path];
    }
    return _dataList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
        _tableView.sd_layout
        .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }
    return _tableView;
}

- (UIBarButtonItem *)postBtn {
    if (!_postBtn) {
        _postBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(postNewArticle:)];
    }
    return _postBtn;
}

- (UIBarButtonItem *)resignBtn {
    if (!_resignBtn) {
        _resignBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(resignAction:)];
    }
    return _resignBtn;
}
- (void)postNewArticle:(id)sender {
    PostViewController *postVc = [[PostViewController alloc] initwithKeyName:self.keyName];
    [self.navigationController pushViewController:postVc animated:YES];
    
//    NSDateFormatter *dateFMT = [[NSDateFormatter alloc] init];
//    dateFMT.dateFormat = @"YYYY-MM-DD";
//    NSDate *current = [NSDate date];
//    NSString *dateStr = [dateFMT stringFromDate:current];
//    
}

- (void)resignAction:(id)sender {
    ViewController *vc = [ViewController new];
    [self.navigationController setViewControllers:@[vc]];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    dispatch_queue_t queueCon = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queueCon, ^{
        NSString *currentAccountPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"CurrentAccount.plist"];
        [[NSFileManager defaultManager] removeItemAtPath:currentAccountPath error:nil];
    });
}
@end

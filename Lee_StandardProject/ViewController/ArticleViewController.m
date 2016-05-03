//
//  ArticleViewController.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/29.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *artTitle;
@property (nonatomic,strong) UITextView *artContent;
@end

@implementation ArticleViewController
- (instancetype)initWithArticleTitle:(NSString *)articleTitle articleContent:(NSString *)articleContent {
    if (self == [super init]) {
        self.articleTitle = articleTitle;
        self.articleContent = articleContent;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self artTitle];
    [self artContent];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 懒加载 Lazy Load
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景2"]];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 20);
    }
    return _scrollView;
}

- (UILabel *)artTitle {
    if (!_artTitle) {
        _artTitle = [UILabel new];
        _artTitle.textColor = [UIColor blueColor];
        _artTitle.font = [UIFont boldSystemFontOfSize:25];
        _artTitle.backgroundColor = [UIColor clearColor];
        _artTitle.textAlignment = NSTextAlignmentCenter;
        _artTitle.text = self.articleTitle;
        [self.scrollView addSubview:_artTitle];
        
        _artTitle.sd_layout
        .topSpaceToView(self.scrollView, 4)
        .centerXEqualToView(self.scrollView)
        .leftSpaceToView(self.scrollView, 15)
        .rightSpaceToView(self.scrollView, 15)
        .heightIs(40);
    }
    return _artTitle;
}

- (UITextView *)artContent {
    if (!_artContent) {
        _artContent = [UITextView new];
        _artContent.backgroundColor = [UIColor clearColor];
        _artContent.font = [UIFont italicSystemFontOfSize:15];
        _artContent.userInteractionEnabled = NO;
        _artContent.textColor = [UIColor darkGrayColor];
        _artContent.text = self.articleContent;
        
        [self.scrollView addSubview:_artContent];
        _artContent.sd_layout
        .topSpaceToView(self.artTitle, 40)
        .leftEqualToView(self.artTitle)
        .rightEqualToView(self.artTitle)
        .centerXEqualToView(self.artTitle)
        .bottomSpaceToView(self.scrollView, 10);
    }
    return _artContent;
}
@end

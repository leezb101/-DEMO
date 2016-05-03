//
//  ArticleViewController.h
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/29.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UIViewController
@property (nonatomic,copy) NSString *articleTitle;
@property (nonatomic,copy) NSString *articleContent;
- (instancetype)initWithArticleTitle:(NSString *)articleTitle articleContent:(NSString *)articleContent;
@end

//
//  ArticleCell.h
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/26.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;
//@property (nonatomic,strong) UITextView *contentTV;
//@property (nonatomic,strong) UILabel *dateLabel;
+ (ArticleCell *)cellWithTableView:(UITableView *)tableView;

@end

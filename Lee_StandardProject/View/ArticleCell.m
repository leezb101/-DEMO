//
//  ArticleCell.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/26.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "ArticleCell.h"

@implementation ArticleCell
#pragma mark - 生命周期 Life Circle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (ArticleCell *)cellWithTableView:(UITableView *)tableView {
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ArticleCell"];
    }
    return cell;
}

#pragma mark - 懒加载 Lazy Load
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 8)
        .rightSpaceToView(self.contentView, 8)
        .maxWidthIs(self.contentView.frame.size.width * 2.0/ 3)
        .autoHeightRatio(0);
    }
    return _titleLabel;
}

//- (UITextView *)contentTV {
//    if (!_contentTV) {
//        _contentTV = [UITextView new];
//        _contentTV.textColor = [UIColor lightGrayColor];
//        _contentTV.font = [UIFont systemFontOfSize:15];
//        _contentTV.backgroundColor = [UIColor clearColor];
//        _contentTV.userInteractionEnabled = NO;
//        [self.contentView addSubview:_contentTV];
//        _contentTV.sd_layout
//        .topSpaceToView(self.titleLabel, 4)
//        .leftEqualToView(self.titleLabel)
//        .rightEqualToView(self.titleLabel)
//        .autoHeightRatio(0);
//    }
//    return _contentTV;
//}
//- (UILabel *)dateLabel {
//    if (!_dateLabel) {
//        _dateLabel = [UILabel new];
//        _dateLabel.textColor = [UIColor lightGrayColor];
//        _dateLabel.font = [UIFont systemFontOfSize:14];
//        _dateLabel.backgroundColor = [UIColor clearColor];
//        
//        [self.contentView addSubview:_dateLabel];
//        _dateLabel.sd_layout
//        .leftSpaceToView(self.titleLabel, 2)
//        .rightSpaceToView(self.contentView, 8)
//        .centerYEqualToView(self.contentView)
//        .autoHeightRatio(0);
//        
//    }
//    return _dateLabel;
//}
@end

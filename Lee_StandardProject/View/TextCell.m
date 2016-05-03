//
//  TextCell.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/25.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - 懒加载 Lazy Load
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor lightGrayColor];
        _label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_label];
        _label.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .centerYEqualToView(self.contentView)
        .widthIs(100)
        .heightIs(32);
    }
    return _label;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
//        _textField.secureTextEntry = YES;
        _textField.layer.borderColor = [UIColor grayColor].CGColor;
        _textField.layer.borderWidth = 1;
        _textField.layer.cornerRadius = 3;
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.backgroundColor = [UIColor colorWithRed:0.8986 green:0.8986 blue:0.8986 alpha:1.0];
        [self.contentView addSubview:_textField];
        _textField.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.label, 5)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(32);
    }
    return _textField;
}
@end

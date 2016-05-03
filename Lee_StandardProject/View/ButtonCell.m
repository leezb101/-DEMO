//
//  ButtonCell.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/25.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 懒加载 Lazy Load
- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_okBtn setBackgroundImage:[UIImage imageNamed:@"btn_orange_nor"] forState:UIControlStateNormal];
        [_okBtn setBackgroundImage:[UIImage imageNamed:@"btn_orange_press"] forState:UIControlStateHighlighted];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okBtn setFont:[UIFont systemFontOfSize:20]];
        
        [self.contentView addSubview:_okBtn];
        _okBtn.sd_layout
        .centerXEqualToView(self.contentView)
        .centerYEqualToView(self.contentView)
        .widthIs(180)
        .heightIs(32);
    }
    return _okBtn;
}

@end

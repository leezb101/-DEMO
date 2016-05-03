//
//  UIView+HUD.h
//  Lee_StandardProject
//
//  Created by leezb101 on 16/3/7.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (HUD)
//忙提示
- (void)showBusyHUD;
//文字提示
- (void)showWarning:(NSString *)warning;
//隐藏提示
- (void)hideBusyHUD;
@end

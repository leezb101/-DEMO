//
//  DetailViewController.h
//  Lee_StandardProject
//
//  Created by leezb101 on 16/4/25.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic,copy) NSString *keyName;
- (instancetype)initWithKeyName:(NSString *)keyName;
@end

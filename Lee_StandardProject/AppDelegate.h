//
//  AppDelegate.h
//  Lee_StandardProject
//
//  Created by leezb101 on 16/2/25.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import <AFNetworkReachabilityManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, getter=isOnLine) BOOL onLine;
@property (nonatomic) AFNetworkReachabilityStatus netReachStatus;
@end


//
//  AppDelegate.m
//  Lee_StandardProject
//
//  Created by leezb101 on 16/2/25.
//  Copyright © 2016年 leezb101. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+System.h"
#import "NaviController.h"
#import "ViewController.h"
#import "DetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //全局默认配置
    [self setupGlobalConfig];
    [UINavigationBar appearance].translucent = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSString *accountInfoPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"AccountInfo.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:accountInfoPath]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AccountInfo" ofType:@"plist"]];
        NSMutableDictionary *accounts = [[NSMutableDictionary alloc] initWithDictionary:dic copyItems:YES];
        
        [accounts writeToFile:accountInfoPath atomically:YES];
    }
    
    NSString *currentAccountPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"CurrentAccount.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:currentAccountPath]) {
        ViewController *viewController = [ViewController new];
        NaviController *naviC = [[NaviController alloc] initWithRootViewController:viewController];
        _window.rootViewController = naviC;
        [_window makeKeyAndVisible];
        return YES;
    }else {
        NSString *keyName = [NSArray arrayWithContentsOfFile:currentAccountPath].firstObject;
        DetailViewController *detailVC = [[DetailViewController alloc] initWithKeyName:keyName];
        NaviController *naviC = [[NaviController alloc] initWithRootViewController:detailVC];
        _window.rootViewController = naviC;
        [_window makeKeyAndVisible];
        
        
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|                                                           UIUserNotificationTypeBadge|
                UIUserNotificationTypeSound
                categories:nil]];
        }else {
            [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|
                UIRemoteNotificationTypeBadge|
                UIRemoteNotificationTypeSound];
        }
        
        UILocalNotification *timeNotification = [UILocalNotification new];
        timeNotification.alertBody = @"该记日记啦~O(∩_∩)O~";
        timeNotification.alertTitle = @"习惯提醒";
        timeNotification.soundName = UILocalNotificationDefaultSoundName;
        timeNotification.applicationIconBadgeNumber = 1;
        timeNotification.fireDate = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 13];
        timeNotification.repeatInterval = NSCalendarUnitDay;
        
        [application scheduleLocalNotification:timeNotification];
        return YES;
    }
    return YES;
}


@end

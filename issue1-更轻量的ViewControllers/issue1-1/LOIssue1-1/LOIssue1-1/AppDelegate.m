//
//  AppDelegate.m
//  LOIssue1-1
//
//  Created by 月之暗面 on 2018/12/14.
//  Copyright © 2018 月之暗面. All rights reserved.
//

#import "AppDelegate.h"
#import "LORootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LORootViewController *rootVC = [[LORootViewController alloc]init];
    UINavigationController *basicNav = [[UINavigationController alloc]initWithRootViewController:rootVC];
    self.window.rootViewController = basicNav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

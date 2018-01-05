//
//  HealthCareAppDelegate.m
//  IHealthCare
//
//  Created by mafanghua on 2017/11/28.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HealthCareAppDelegate.h"
#import "HealthCareViewControllerManager.h"
#import "MMServiceCenter.h"
#import "MFThemeHelper.h"
#import "IQKeyboardManager.h"
#import "WXApiManager.h"

#define WXKey @"wxfddaeb6d71257dc9"

@interface HealthCareAppDelegate ()
{
    MMServiceCenter *m_serviceCenter;
    HealthCareViewControllerManager *m_appViewControllerMgr;
}

@end

@implementation HealthCareAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    m_appViewControllerMgr = [HealthCareViewControllerManager getAppViewControllerManager];
    [m_appViewControllerMgr setRootMainWindow:self.window];
    
//#ifdef DEBUG
//    [m_appViewControllerMgr launchMainTabViewController];
//#else
//    [m_appViewControllerMgr launchLoginViewController];
//#endif
    
    [m_appViewControllerMgr launchLoginViewController];
    
    [MFThemeHelper setDefaultThemeColor];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [self registerWXPay];
    
    return YES;
}

-(void)registerWXPay
{
    [WXApi registerApp:WXKey enableMTA:NO];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

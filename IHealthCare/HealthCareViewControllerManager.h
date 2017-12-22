//
//  HealthCareViewControllerManager.h
//  IHealthCare
//
//  Created by mafanghua on 2017/11/30.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMService.h"
#import "HealthCareTabBarController.h"

@interface HealthCareViewControllerManager : MMService
{
    UIWindow *m_window;
    HealthCareTabBarController *m_tabbarController;
}

+ (id)getAppViewControllerManager;
-(void)setRootMainWindow:(UIWindow *)window;
-(void)launchMainTabViewController;
-(void)launchLoginViewController;

@end

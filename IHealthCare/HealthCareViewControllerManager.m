//
//  HealthCareViewControllerManager.m
//  IHealthCare
//
//  Created by mafanghua on 2017/11/30.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HealthCareViewControllerManager.h"
#import "HCLoginViewController.h"
#import "HCTopCureMainViewController.h"
#import "HCHealthManagementViewController.h"
#import "HCWealthManagementViewController.h"
#import "HCHappinessManagementViewController.h"
#import "HCMeViewController.h"
#import "HealthCareCenterMenuMainView.h"

@interface HealthCareViewControllerManager () <HealthCareTabBarControllerDelegate,HealthCareCenterMenuMainViewDelegate>
{
    HealthCareCenterMenuMainView *m_menuView;
}

@end

@implementation HealthCareViewControllerManager

+(id)getAppViewControllerManager
{
    HealthCareViewControllerManager *appViewControllerManager = [[MMServiceCenter defaultCenter] getService:[HealthCareViewControllerManager class]];
    return appViewControllerManager;
}

-(void)setRootMainWindow:(UIWindow *)window
{
    m_window = window;
}

-(void)launchLoginViewController
{
    HCLoginViewController *loginVC = [HCLoginViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:loginVC];
    m_window.rootViewController = rootNav;
}

-(void)launchMainTabViewController
{
    UIViewController *topCureMainVC = [self topCureMainVC];
    UIViewController *healthManagementMainVC = [self healthManagementMainVC];
    UIViewController *centerMainVC = [self centerMainVC];
    UIViewController *wealthManagementMainVC = [self wealthManagementMainVC];
    UIViewController *happinessManagementMainVC = [self happinessManagementMainVC];
    
    m_tabbarController = [self getTabBarController];
    m_tabbarController.viewControllers = @[topCureMainVC,healthManagementMainVC,centerMainVC,wealthManagementMainVC,happinessManagementMainVC];
    m_tabbarController.tabBar.backgroundColor = [UIColor hx_colorWithHexString:@"FFFFFF"];
    m_window.rootViewController = m_tabbarController;
    [m_tabbarController setSelectedIndex:0];
}

- (HealthCareTabBarController *)getTabBarController
{
    if (!m_tabbarController) {
        m_tabbarController = [[HealthCareTabBarController alloc] init];
        m_tabbarController.m_delegate = self;
    }
    
    return m_tabbarController;
}

#pragma mark - HealthCareTabBarControllerDelegate
-(void)onClickTabBarCenterMenuView:(HealthCareTabBarController *)tabBarController
{
    if (!m_menuView) {
        m_menuView = [HealthCareCenterMenuMainView nibView];
        m_menuView.frame = MFAppWindow.bounds;
        m_menuView.backgroundColor = [UIColor hx_colorWithHexString:@"000000" alpha:0.53];
        m_menuView.m_delegate = self;
    }
    
    [MFAppWindow addSubview:m_menuView];
}

#pragma mark - HealthCareTabBarControllerDelegate
-(void)onClickMenu:(HealthCareCenterMenuMainView *)menuView actionKey:(NSString *)key
{
    
}

-(void)onClickCloseButton:(HealthCareCenterMenuMainView *)menuView
{
    [m_menuView removeFromSuperview];
}

-(void)onClickShowMyInfo:(HealthCareCenterMenuMainView *)menuView
{
    [m_menuView removeFromSuperview];
    
    UIViewController *selectVC = m_tabbarController.selectedViewController;
    if ([selectVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *selectNav = (UINavigationController *)selectVC;
        HCMeViewController *meVC = [HCMeViewController new];
        meVC.hidesBottomBarWhenPushed = YES;
        [selectNav pushViewController:meVC animated:YES];
    }
}

-(UIViewController *)centerMainVC
{
    UIViewController *mainVC = [UIViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:mainVC];
    return rootNav;
}

-(UIViewController *)topCureMainVC
{
    HCTopCureMainViewController *topCureVC = [HCTopCureMainViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:topCureVC];
    UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"高端医疗"
                                                              image:[MFImage(@"common_tab_medical_nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[MFImage(@"common_tab_medical_press") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rootNav.tabBarItem = tabItem;

    return rootNav;
}

-(UIViewController *)healthManagementMainVC
{
    HCHealthManagementViewController *mainVC = [HCHealthManagementViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:mainVC];
    UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"健康管理"
                                                              image:[MFImage(@"common_tab_health_nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[MFImage(@"common_tab_health_press") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rootNav.tabBarItem = tabItem;
    
    return rootNav;
}

-(UIViewController *)wealthManagementMainVC
{
    HCWealthManagementViewController *mainVC = [HCWealthManagementViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:mainVC];
    UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"财富管理"
                                                          image:[MFImage(@"common_tab_wealth_nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                  selectedImage:[MFImage(@"common_tab_wealth_press") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rootNav.tabBarItem = tabItem;
    
    return rootNav;
}

-(UIViewController *)happinessManagementMainVC
{
    HCHappinessManagementViewController *mainVC = [HCHappinessManagementViewController new];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:mainVC];
    UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"幸福管理"
                                                          image:[MFImage(@"common_tab_happiness_nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                  selectedImage:[MFImage(@"common_tab_happiness_press") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rootNav.tabBarItem = tabItem;
    
    return rootNav;
}

@end

//
//  HealthCareTabBarController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HealthCareTabBarController.h"

@interface HealthCareTabBarController ()
{
    UIButton *m_centerButton;
}

@end

@implementation HealthCareTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_centerButton addTarget:self action:@selector(onClickCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    m_centerButton.frame = CGRectMake((CGRectGetWidth(self.tabBar.frame) - 70) / 2, 0, 70, 49);
    [m_centerButton setImage:MFImage(@"common_tab_more_nor") forState:UIControlStateNormal];
    [m_centerButton setImage:MFImage(@"common_tab_more_press") forState:UIControlStateHighlighted];
    [self.tabBar addSubview:m_centerButton];
}

-(void)setTabBarButtonHidden:(NSInteger)index
{
    int i = 0;
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == index)
            {
                m_centerButton.frame = CGRectMake((CGRectGetWidth(self.tabBar.frame) - 70) / 2, 0, 70, 49);
                [tabBarButton setHidden:YES];
            }
            i++;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarButtonHidden:2];
    [self.tabBar bringSubviewToFront:m_centerButton];
}

-(void)onClickCenterButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickTabBarCenterMenuView:)]) {
        [self.m_delegate onClickTabBarCenterMenuView:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

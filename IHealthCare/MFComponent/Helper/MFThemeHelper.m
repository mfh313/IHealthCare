//
//  MFThemeHelper.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFThemeHelper.h"

@implementation MFThemeHelper

+(void)setDefaultThemeColor
{
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor clearColor];
    NSDictionary *textAttributes = @{NSShadowAttributeName: shadow,NSForegroundColorAttributeName:MFCustomNavBarTitleColor,NSFontAttributeName:[UIFont systemFontOfSize:16.0]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:MFCustomNavBarColor];
    [[UINavigationBar appearance] setBackgroundImage:MFImageStretchCenter(@"title_bg") forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexString:@"5D5D5D"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexString:@"E0C079"]} forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
    [[UITextField appearance] setTintColor:[UIColor hx_colorWithHexString:@"F9C255"]];
    
    [[MZFormSheetPresentationController appearance] setBackgroundColor:[UIColor hx_colorWithHexString:@"000000" alpha:0.53]];

}

@end

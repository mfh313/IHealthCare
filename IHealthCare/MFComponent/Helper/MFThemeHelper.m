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
    
    [LGAlertView appearance].tintColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    [LGAlertView appearance].titleFont = [UIFont systemFontOfSize:18.0];
    [LGAlertView appearance].messageFont = [UIFont systemFontOfSize:15.0];
    [LGAlertView appearance].cancelButtonTitleColor = [UIColor hx_colorWithHexString:@"305b6a"];
    [LGAlertView appearance].cancelButtonTitleColorHighlighted = [UIColor hx_colorWithHexString:@"242834"];
    [LGAlertView appearance].cancelButtonFont = [UIFont systemFontOfSize:15.0];
    [LGAlertView appearance].buttonsFont = [UIFont systemFontOfSize:15.0];
    [LGAlertView appearance].buttonsTitleColor = [UIColor hx_colorWithHexString:@"242834"];
    [LGAlertView appearance].buttonsTitleColorHighlighted = [UIColor hx_colorWithHexString:@"305b6a"];
    
}

@end

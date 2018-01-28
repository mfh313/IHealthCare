//
//  MFAppMacroUtil.m
//  EekaMShop
//
//  Created by EEKA on 2017/8/31.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFAppMacroUtil.h"

NSString *const WXPay_Notification_Success = @"WXPay_Notification_Success";

@implementation MFAppMacroUtil

+ (NSString *)getCFBundleVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Version;
}

@end

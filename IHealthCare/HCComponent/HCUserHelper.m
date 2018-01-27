//
//  HCUserHelper.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserHelper.h"
#import "HCUserModel.h"

@implementation HCUserHelper

+(NSString *)userLevelDescription:(NSInteger)level
{
    if (level == HCUserLevel_1)
    {
        return @"用户";
    }
    else if (level == HCUserLevel_2)
    {
        return @"VIP";
    }
    else if (level == HCUserLevel_3)
    {
        return @"大客户";
    }
    else if (level == HCUserLevel_4)
    {
        return @"签约代理商";
    }
    else if (level == HCUserLevel_5)
    {
        return @"直属代理商";
    }
    else if (level == HCUserLevel_6)
    {
        return @"合伙人";
    }
    
    return @"级别";
}

@end

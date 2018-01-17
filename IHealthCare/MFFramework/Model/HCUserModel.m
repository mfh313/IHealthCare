//
//  HCUserModel.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserModel.h"

NSInteger const HCUserLevel_1 = 1; //用户
NSInteger const HCUserLevel_2 = 2; //VIP
NSInteger const HCUserLevel_3 = 3; //大客户
NSInteger const HCUserLevel_4 = 4; //签约代理商
NSInteger const HCUserLevel_5 = 5; //直属代理商
NSInteger const HCUserLevel_6 = 6; //合伙人

NSInteger const HCUser_male = 0; //男
NSInteger const HCUser_female = 1; //女

NSInteger const HCUserAuthStatus_UnAuthorized = 1; //未认证
NSInteger const HCUserAuthStatus_Authoring = 2; //认证中
NSInteger const HCUserAuthStatus_Authorized = 3; //已认证

@implementation HCUserModel

-(NSString *)userLevelDescription
{
    switch (self.level) {
        case HCUserLevel_1:
            return @"用户";
            break;
        case HCUserLevel_2:
            return @"VIP";
            break;
        case HCUserLevel_3:
            return @"大客户";
            break;
        case HCUserLevel_4:
            return @"签约代理商";
            break;
        case HCUserLevel_5:
            return @"直属代理商";
            break;
        case HCUserLevel_6:
            return @"合伙人";
            break;
            
        default:
            break;
    }
    
    return @"级别";
}

@end

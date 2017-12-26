//
//  HCManagementDetailModel.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/22.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCManagementDetailModel.h"

NSInteger const CONTROL_HEALTH = 3;  //健康管理
NSInteger const CONTROL_WEALTH = 4;  //财富管理
NSInteger const CONTROL_HAPPINESS = 5; //幸福管理

@implementation HCManagementDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"managerDescription" : @"description"
             };
}

@end

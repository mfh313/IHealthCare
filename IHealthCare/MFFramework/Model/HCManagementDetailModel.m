//
//  HCManagementDetailModel.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/22.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCManagementDetailModel.h"

NSInteger const CONTROL_HEALTH = 1;
NSInteger const CONTROL_WEALTH = 2;
NSInteger const CONTROL_HAPPINESS = 3;

@implementation HCManagementDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"managerDescription" : @"description"
             };
}

@end

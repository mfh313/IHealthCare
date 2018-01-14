//
//  HCSubClassDetailModel.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCSubClassDetailModel.h"

@implementation HCSubClassDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"subClassDescription" : @"description"
             };
}

@end

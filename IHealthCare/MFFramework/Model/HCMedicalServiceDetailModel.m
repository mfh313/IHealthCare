//
//  HCMedicalServiceDetailModel.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCMedicalServiceDetailModel.h"

@implementation HCMedicalServiceDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"serviceDescription" : @"description"
             };
}

@end

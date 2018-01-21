//
//  HCCmsCommonModel.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCmsCommonModel.h"

@implementation HCCmsCommonModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"cmsDescription" : @"description",
             @"cmsId" : @"id"
             };
}

@end

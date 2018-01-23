//
//  HCCommentsDetailModel.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCommentsDetailModel.h"

@implementation HCCommentsDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"recordId" : @"id"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user" : [HCUserModel class]};
}

@end

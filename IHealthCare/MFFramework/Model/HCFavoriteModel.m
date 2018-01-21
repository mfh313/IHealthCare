//
//  HCFavoriteModel.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCFavoriteModel.h"

@implementation HCFavoriteModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"favoriteId" : @"id",
             @"favoriteData" : @"cmsCommon"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"favoriteData" : [HCCmsCommonModel class]};
}

@end

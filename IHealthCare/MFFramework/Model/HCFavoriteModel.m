//
//  HCFavoriteModel.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCFavoriteModel.h"

NSInteger const HCFavorite_category_1 = 1;   //高品服务
NSInteger const HCFavorite_category_2 = 2;   //健康管理交易类
NSInteger const HCFavorite_category_3 = 3;   //服务显示类
NSInteger const HCFavorite_category_4 = 4;   //资讯显示类
NSInteger const HCFavorite_category_5 = 5;   //大讲堂类

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

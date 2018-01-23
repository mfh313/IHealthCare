//
//  HCDeleteFavoriteApi.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCDeleteFavoriteApi.h"

@implementation HCDeleteFavoriteApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger deleteFavorites:self.fid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodDELETE;
}

@end

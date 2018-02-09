//
//  HCGetClassesBannerApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/2/9.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetClassesBannerApi.h"

@implementation HCGetClassesBannerApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger classesBanner:self.csid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

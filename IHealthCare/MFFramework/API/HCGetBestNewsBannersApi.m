//
//  HCGetBestNewsBannersApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/2/9.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetBestNewsBannersApi.h"

@implementation HCGetBestNewsBannersApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger bestNewsBanner];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


@end

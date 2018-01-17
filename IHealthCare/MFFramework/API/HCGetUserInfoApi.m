//
//  HCGetUserInfoApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/17.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetUserInfoApi.h"

@implementation HCGetUserInfoApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger userInfo:self.userTel];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

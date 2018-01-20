//
//  HCPutUserInfoApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCPutUserInfoApi.h"

@implementation HCPutUserInfoApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger putUserInfo];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPUT;
}

@end

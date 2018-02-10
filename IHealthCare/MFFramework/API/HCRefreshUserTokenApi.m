//
//  HCRefreshUserTokenApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/29.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCRefreshUserTokenApi.h"

@implementation HCRefreshUserTokenApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger refreshToken];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPUT;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"userTel"] = self.userTel;
    requestArgument[@"authCode"] = self.authCode;
    requestArgument[@"modifyTime"] = self.modifyTime;
    return requestArgument;
}


@end

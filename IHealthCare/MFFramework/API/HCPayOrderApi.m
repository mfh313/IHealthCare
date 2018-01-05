//
//  HCPayOrderApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCPayOrderApi.h"

@implementation HCPayOrderApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger payOrder:self.oid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"userTel"] = self.userTel;
    requestArgument[@"authCode"] = self.authCode;
    requestArgument[@"oid"] = @(self.oid);
    return requestArgument;
}

@end

//
//  HCCreateOrderApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/5.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCreateOrderApi.h"


@implementation HCCreateOrderApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger createOrder];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"userTel"] = self.userTel;
    requestArgument[@"authCode"] = self.authCode;
    requestArgument[@"name"] = self.name;
    requestArgument[@"phone"] = self.phone;
    requestArgument[@"addr"] = self.addr;
    requestArgument[@"carts"] = [self.carts yy_modelToJSONObject];
    return requestArgument;
}

@end

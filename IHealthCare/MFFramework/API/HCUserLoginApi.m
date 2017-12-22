//
//  HCUserLoginApi.m
//  IHealthCare
//
//  Created by 马方华 on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCUserLoginApi.h"

@implementation HCUserLoginApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger userLogin];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"telephone"] = self.telephone;
    requestArgument[@"verifyCode"] = self.verifyCode;
    return requestArgument;
}

@end

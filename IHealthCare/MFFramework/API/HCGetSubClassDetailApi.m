//
//  HCGetSubClassDetailApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetSubClassDetailApi.h"

@implementation HCGetSubClassDetailApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger subClassesDetail:self.crid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"userTel"] = self.userTel;
    requestArgument[@"authCode"] = self.authCode;
    
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    requestArgument[@"nodeId"] = identifierForVendor;
    
    return requestArgument;
}

@end

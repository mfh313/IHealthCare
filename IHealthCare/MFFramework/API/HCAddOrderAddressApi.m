//
//  HCAddOrderAddressApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCAddOrderAddressApi.h"

@implementation HCAddOrderAddressApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger addOrderAddress];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"userTel"] = self.userTel;
    requestArgument[@"name"] = self.name;
    requestArgument[@"phone"] = self.phone;
    requestArgument[@"addr"] = self.addr;
    requestArgument[@"city"] = self.city;
    return requestArgument;
}

@end

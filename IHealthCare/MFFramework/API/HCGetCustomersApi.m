//
//  HCGetCustomersApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetCustomersApi.h"

@implementation HCGetCustomersApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger customer:self.tel page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

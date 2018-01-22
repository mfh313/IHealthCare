//
//  HCGetOrdersApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetOrdersApi.h"

@implementation HCGetOrdersApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger orders:self.tel page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

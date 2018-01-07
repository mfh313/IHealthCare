//
//  HCGetOrderUserAddressApi.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetOrderUserAddressApi.h"

@implementation HCGetOrderUserAddressApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger getUserOrderAddress:self.userTel];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

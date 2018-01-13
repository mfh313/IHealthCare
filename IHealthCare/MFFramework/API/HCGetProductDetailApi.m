//
//  HCGetProductDetailApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetProductDetailApi.h"

@implementation HCGetProductDetailApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger productDetail:self.pid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

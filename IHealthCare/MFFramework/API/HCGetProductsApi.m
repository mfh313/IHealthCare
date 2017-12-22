//
//  HCGetProductsApi.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/16.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCGetProductsApi.h"

NSInteger const PRODUCT_HIGHT_SERVICE = 1;  //高品服务
NSInteger const PRODUCT_GENERAL = 2;  //正常产品
NSInteger const PRODUCT_CLASS_ROOM = 3;  //大讲堂

@implementation HCGetProductsApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger products:self.cid page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

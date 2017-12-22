//
//  HCGetBestNewsApi.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/17.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCGetBestNewsApi.h"

NSInteger const BestNews_Type_Default = 1;

@implementation HCGetBestNewsApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger bestNews:self.type page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

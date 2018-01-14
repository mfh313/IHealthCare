//
//  HCGetClassDetailApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetClassDetailApi.h"

@implementation HCGetClassDetailApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger classDetail:self.pid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

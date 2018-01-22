//
//  HCGetMyClassesApi.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetMyClassesApi.h"

@implementation HCGetMyClassesApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger myClasses:self.tel page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

//
//  HCGetHealthMedicalServiceApi.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCGetHealthMedicalServiceApi.h"

@implementation HCGetHealthMedicalServiceApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger healthMedicalService:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

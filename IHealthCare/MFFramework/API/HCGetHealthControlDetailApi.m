//
//  HCGetHealthControlDetailApi.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetHealthControlDetailApi.h"

@implementation HCGetHealthControlDetailApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger getHealthControlDetail:self.hcid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

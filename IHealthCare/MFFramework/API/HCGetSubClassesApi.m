//
//  HCGetSubClassesApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetSubClassesApi.h"

@implementation HCGetSubClassesApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger subClassesDetail:self.crid page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

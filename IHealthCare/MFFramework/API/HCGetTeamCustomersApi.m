//
//  HCGetTeamCustomersApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetTeamCustomersApi.h"

@implementation HCGetTeamCustomersApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger team:self.tel page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

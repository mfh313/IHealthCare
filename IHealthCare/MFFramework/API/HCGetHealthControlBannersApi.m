//
//  HCGetHealthControlBannersApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/2/9.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetHealthControlBannersApi.h"

@implementation HCGetHealthControlBannersApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger healthControlsBanner:self.csid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

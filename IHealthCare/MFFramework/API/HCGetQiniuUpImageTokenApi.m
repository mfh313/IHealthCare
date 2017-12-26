//
//  HCGetQiniuUpImageTokenApi.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/25.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCGetQiniuUpImageTokenApi.h"

@implementation HCGetQiniuUpImageTokenApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger upImageToken];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

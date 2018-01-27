//
//  HCUserPromoteApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserPromoteApi.h"

@implementation HCUserPromoteApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger promote:self.tel];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPUT;
}

@end

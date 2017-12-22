//
//  HCGetVerifyCodeApi.m
//  IHealthCare
//
//  Created by 马方华 on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCGetVerifyCodeApi.h"

@implementation HCGetVerifyCodeApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger getVerifycode:self.telephone];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

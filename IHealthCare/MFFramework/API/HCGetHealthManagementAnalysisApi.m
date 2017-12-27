//
//  HCGetHealthManagementAnalysisApi.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCGetHealthManagementAnalysisApi.h"

@implementation HCGetHealthManagementAnalysisApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger healthAnalysis:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

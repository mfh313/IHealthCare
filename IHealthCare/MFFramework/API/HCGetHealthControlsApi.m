//
//  HCGetHealthControlsApi.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/26.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCGetHealthControlsApi.h"

@implementation HCGetHealthControlsApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger healthControls:self.type page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

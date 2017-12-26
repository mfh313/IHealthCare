//
//  HCGetClassRoomApi.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCGetClassRoomApi.h"

@implementation HCGetClassRoomApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger classRoomPage:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

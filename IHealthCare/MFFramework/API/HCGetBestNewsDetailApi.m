//
//  HCGetBestNewsDetailApi.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetBestNewsDetailApi.h"

@implementation HCGetBestNewsDetailApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger getBestNewsDetail:self.bid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

//
//  HCGetFavoritesApi.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetFavoritesApi.h"

@implementation HCGetFavoritesApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger favorites:self.tel page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

//
//  HCAddFavoritesApi.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCAddFavoritesApi.h"

@implementation HCAddFavoritesApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger favorites];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"favoriteId"] = @(self.favoriteId);
    requestArgument[@"userTel"] = self.userTel;
    requestArgument[@"category"] = @(self.category);
    return requestArgument;
}

@end

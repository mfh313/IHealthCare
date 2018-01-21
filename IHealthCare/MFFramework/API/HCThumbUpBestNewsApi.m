//
//  HCThumbUpBestNewsApi.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCThumbUpBestNewsApi.h"

@implementation HCThumbUpBestNewsApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger thumbUpBestNews:self.bid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPUT;
}

@end

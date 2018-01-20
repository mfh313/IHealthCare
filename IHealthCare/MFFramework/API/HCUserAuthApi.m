//
//  HCUserAuthApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/19.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserAuthApi.h"

@implementation HCUserAuthApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger userAuth];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"telephone"] = self.telephone;
    requestArgument[@"name"] = self.name;
    requestArgument[@"idNumber"] = self.idNumber;
    requestArgument[@"idImageUrl"] = self.idImageUrl;
    requestArgument[@"city"] = self.city;
    requestArgument[@"bankCardId"] = self.bankCardId;
    requestArgument[@"company"] = self.company;
    requestArgument[@"level"] = self.level;
    return requestArgument;
}

@end

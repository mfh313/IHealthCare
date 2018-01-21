//
//  HCPutUserInfoApi.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCPutUserInfoApi.h"

@implementation HCPutUserInfoApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger putUserInfo];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPUT;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"name"] = self.name;
    requestArgument[@"telephone"] = self.telephone;
    requestArgument[@"address"] = self.address;
    requestArgument[@"idNumber"] = self.idNumber;
    requestArgument[@"bankCardId"] = self.bankCardId;
    requestArgument[@"company"] = self.company;
    requestArgument[@"imageUrl"] = self.imageUrl;
    if (self.sex) {
        requestArgument[@"sex"] = self.sex;
    }
    if (self.age) {
        requestArgument[@"age"] = self.age;
    }
    requestArgument[@"preUserphone"] = self.preUserphone;
    return requestArgument;
}

@end

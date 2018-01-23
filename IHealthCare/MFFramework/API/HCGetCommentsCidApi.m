//
//  HCGetCommentsCidApi.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCGetCommentsCidApi.h"

@implementation HCGetCommentsCidApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger comments:self.cid commentedId:self.commentedId page:self.page];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

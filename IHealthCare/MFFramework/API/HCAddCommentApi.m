//
//  HCAddCommentApi.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCAddCommentApi.h"

@implementation HCAddCommentApi

-(NSString *)requestUrl
{
    return [HealthCareApiManger comments];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"commentedId"] = @(self.commentedId);
    requestArgument[@"userTel"] = self.userTel;
    requestArgument[@"category"] = @(self.category);
    requestArgument[@"title"] = self.title;
    requestArgument[@"content"] = self.content;
    return requestArgument;
}

@end

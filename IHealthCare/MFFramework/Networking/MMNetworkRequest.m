//
//  MMNetworkRequest.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/8.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@implementation MMNetworkRequest

-(BOOL)useGlobalAppToken
{
    return YES;
}

-(id)requestArgumentWithToken
{
    return nil;
}

-(YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

-(id)requestArgument
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    if ([self useGlobalAppToken])
    {
        /*
         MShopLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[MShopLoginService class]];
         NSString *token = [loginService getCurrentLoginToken];
         if (![MFStringUtil isBlankString:token]) {
         [requestArgument setObject:token forKey:@"token"];
         }
         */
        
        if ([self requestArgumentWithToken])
        {
            [requestArgument addEntriesFromDictionary:[self requestArgumentWithToken]];
        }
    }
    
    return requestArgument;
}

-(void)setCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure
{
    __weak __typeof(self) weakSelf = self;
    
    [super setCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        success(request);
        
    } failure:failure];
}

-(BOOL)messageSuccess
{
    if (![self.responseJSONObject isKindOfClass:[NSDictionary class]])
    {
        return YES;
    }
    
    NSDictionary *dict = self.responseJSONObject;
    NSNumber *number = dict[@"code"];
    if (number.intValue == 0)
    {
        return YES;
    }
    
    return NO;
}

-(NSString*)errorMessage
{
    if (![self.responseJSONObject isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    NSDictionary *dict = self.responseJSONObject;
    id string = dict[@"errorMessage"];
    if ([string isKindOfClass:[NSNull class]]) {
        string = @"服务器无错误描述";
    }
    
    return string;
}

-(id)responseNetworkData
{
    if (![self.responseJSONObject isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    return self.responseJSONObject[@"data"];
}

@end

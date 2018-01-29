//
//  HCLoginService.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/5.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCLoginService.h"
#import "HCRefreshUserTokenApi.h"

@implementation HCLoginService

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if (![MFStringUtil isBlankString:self.userPhone]
        && ![MFStringUtil isBlankString:self.token])
    {
        [self refreshToken];
    }
}

-(void)refreshToken
{
    __weak typeof(self) weakSelf = self;
    HCRefreshUserTokenApi *mfApi = [HCRefreshUserTokenApi new];
    mfApi.userTel = self.userPhone;
    mfApi.authCode = self.token;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            return;
        }
        
        NSDictionary *tokenInfo = mfApi.responseNetworkData;
        strongSelf.token = tokenInfo[@"accessToken"];
        
        NSLog(@"refreshToken=%@",strongSelf.token);
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

@end

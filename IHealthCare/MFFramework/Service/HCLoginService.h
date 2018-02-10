//
//  HCLoginService.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/5.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMService.h"

@interface HCLoginService : MMService

@property (nonatomic,strong) NSString *userPhone;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *tokenModifyTime;

- (void)autoLogin;
- (void)updateLastLoginInfoInDB:(NSString *)userPhone token:(NSString *)token tokenModifyTime:(NSString *)tokenModifyTime;
- (void)deleteLastLoginInfoInDB;
- (void)applicationDidBecomeActive:(UIApplication *)application;

@end


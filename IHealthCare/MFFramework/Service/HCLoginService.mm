//
//  HCLoginService.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/5.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCLoginService.h"
#import "HCRefreshUserTokenApi.h"
#import <WCDB/WCDB.h>
#import "HCUserLoginTable+WCDB.h"
#import "HCQiniuFileService.h"

#define MFDocumentDirectory NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

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
    mfApi.modifyTime = self.tokenModifyTime;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            return;
        }
        
        NSDictionary *tokenInfo = mfApi.responseNetworkData;
        strongSelf.token = tokenInfo[@"accessToken"];
        strongSelf.tokenModifyTime = tokenInfo[@"modifyTime"];
        
        if ([strongSelf.token isKindOfClass:[NSNull class]]
            || [strongSelf.tokenModifyTime isKindOfClass:[NSNull class]]) {
            return;
        }
        
        [strongSelf deleteLastLoginInfoInDB];
        [strongSelf updateLastLoginInfoInDB:strongSelf.userPhone token:strongSelf.token tokenModifyTime:strongSelf.tokenModifyTime];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

-(void)autoLogin
{
    NSString *token = [self getCurrentLoginToken];
    
    if (![MFStringUtil isBlankString:token])
    {
        HCQiniuFileService *qiniuService = [[MMServiceCenter defaultCenter] getService:[HCQiniuFileService class]];
        [qiniuService getImageToken];
        
        [self readDBLoginUserInfo];
        [self refreshToken];
        
        [[HealthCareViewControllerManager getAppViewControllerManager] launchMainTabViewController];
    }
    else
    {
        [[HealthCareViewControllerManager getAppViewControllerManager] launchLoginViewController];
    }
}

-(void)readDBLoginUserInfo
{
    Class cls = HCUserLoginTable.class;
    NSString *tableName = NSStringFromClass(cls);
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:tableName];
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    
    
    WCTTable *table = [database getTableOfName:tableName
                                     withClass:cls];
    HCUserLoginTable *loginInfo = [table getOneObject];
    
    self.userPhone = loginInfo.userPhone;
    self.token = loginInfo.token;
    self.tokenModifyTime = loginInfo.tokenModifyTime;
}


-(NSString *)getCurrentLoginToken
{
    NSString *className = NSStringFromClass(HCUserLoginTable.class);
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:className];
    NSString *tableName = className;
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    
    WCTTable *table = [database getTableOfName:tableName
                                     withClass:HCUserLoginTable.class];
    HCUserLoginTable *loginInfo = [table getOneObject];
    return loginInfo.token;
}

- (void)updateLastLoginInfoInDB:(NSString *)userPhone token:(NSString *)token tokenModifyTime:(NSString *)tokenModifyTime
{
    NSString *className = NSStringFromClass(HCUserLoginTable.class);
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:className];
    NSString *tableName = className;
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    [database close:^{
        [database removeFilesWithError:nil];
    }];
    
    [database createTableAndIndexesOfName:tableName
                                withClass:HCUserLoginTable.class];
    
    
    WCTTable *table = [database getTableOfName:tableName
                                     withClass:HCUserLoginTable.class];
    
    
    HCUserLoginTable *object = [[HCUserLoginTable alloc] init];
    object.token = token;
    object.userPhone = userPhone;
    object.tokenModifyTime = tokenModifyTime;
    [table insertObject:object];
}

-(void)deleteLastLoginInfoInDB
{
    NSString *className = NSStringFromClass(HCUserLoginTable.class);
    NSString *path = [MFDocumentDirectory stringByAppendingPathComponent:className];
    NSString *tableName = className;
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    WCTTable *table = [database getTableOfName:tableName
                                     withClass:HCUserLoginTable.class];
    [table deleteAllObjects];
}

@end

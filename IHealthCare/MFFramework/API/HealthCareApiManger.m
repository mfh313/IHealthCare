//
//  HealthCareApiManger.m
//  IHealthCare
//
//  Created by 马方华 on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HealthCareApiManger.h"

#define MFURL [HealthCareApiManger hostUrl]

#define MFURLWithPara(para) [MFURL stringByAppendingPathComponent:para]

NSString *const ServerUrl = @"http://120.78.79.10:8080/";
NSString *const test_ServerUrl = @"http://120.78.79.10:8080/";

@implementation HealthCareApiManger

+ (NSString *)hostUrl
{
    return test_ServerUrl;
}

+ (NSString *)upImageToken
{
    return MFURLWithPara(@"api/users/upToken");
}

+ (NSString *)healthControls:(NSInteger )type page:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/healthControls/%@/%@",@(type),@(page)];
    return MFURLWithPara(parmUrl);
}

+ (NSString *)bestNews:(NSInteger )type page:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/bestNews/%@/%@",@(type),@(page)];
    return MFURLWithPara(parmUrl);
}

+ (NSString *)products:(NSInteger )cid page:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/products/%@/%@",@(cid),@(page)];
    return MFURLWithPara(parmUrl);
}

+ (NSString *)getVerifycode:(NSString *)telephone
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/users/verifycode/%@",telephone];
    return MFURLWithPara(parmUrl);
}

+ (NSString *)userLogin
{
    return MFURLWithPara(@"api/users/login");
}

@end

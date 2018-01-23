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

//删除收藏
+ (NSString *)deleteFavorites:(NSInteger)fid
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/favorites/%@",@(fid)];
    return MFURLWithPara(parmUrl);
}

//查询订单列表
+ (NSString *)orders:(NSString *)tel page:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/orders/%@/%@",tel,@(page)];
    return MFURLWithPara(parmUrl);
}

//查询我的课程
+ (NSString *)myClasses:(NSString *)tel page:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/myClasses/%@/%@",tel,@(page)];
    return MFURLWithPara(parmUrl);
}

//查询我的收藏
+ (NSString *)favorites:(NSString *)tel page:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/favorites/%@/%@",tel,@(page)];
    return MFURLWithPara(parmUrl);
}

//点赞前沿资讯
+ (NSString *)thumbUpBestNews:(NSInteger)bid
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/bestNews/thumbUp/%@",@(bid)];
    return MFURLWithPara(parmUrl);
}

//查询前沿资讯详情
+ (NSString *)getBestNewsDetail:(NSInteger)bid
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/bestNews/%@",@(bid)];
    return MFURLWithPara(parmUrl);
}

//添加收藏
+ (NSString *)favorites
{
    return MFURLWithPara(@"api/favorites");
}

//修改用户信息
+ (NSString *)putUserInfo
{
    return MFURLWithPara(@"api/users");
}

//查询健康管理详情
+ (NSString *)getHealthControlDetail:(NSInteger)hcid
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/healthControls/%@",@(hcid)];
    return MFURLWithPara(parmUrl);
}

//身份认证
+ (NSString *)userAuth
{
    return MFURLWithPara(@"api/users/auth");
}

//查询子课程详情
+ (NSString *)subClassesDetail:(NSInteger)crid
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/subClasses/%@",@(crid)];
    return MFURLWithPara(parmUrl);
}

//查询子课程列表
+ (NSString *)subClassesDetail:(NSInteger)crid page:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/subClasses/%@/%@",@(crid),@(page)];
    return MFURLWithPara(parmUrl);
}

//查询课程详情
+ (NSString *)classDetail:(NSInteger)pid
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/classes/%@",@(pid)];
    return MFURLWithPara(parmUrl);
}

//修改地址
+ (NSString *)modifyOrderAddress:(NSInteger)aid
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/address/%@",@(aid)];
    return MFURLWithPara(parmUrl);
}

//增加订单地址
+ (NSString *)addOrderAddress
{
    return MFURLWithPara(@"api/address");
}

//订单地址列表
+ (NSString *)getUserOrderAddress:(NSString *)tel
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/address/%@",tel];
    return MFURLWithPara(parmUrl);
}

//订单支付
+ (NSString *)payOrder:(NSInteger)oid
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/orders/%@",@(oid)];
    return MFURLWithPara(parmUrl);
}

//提交订单
+ (NSString *)createOrder
{
    return MFURLWithPara(@"api/orders");
}

+ (NSString *)healthAnalysis:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/medicalService/1/%@",@(page)];
    return MFURLWithPara(parmUrl);
}

+ (NSString *)healthMedicalService:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/medicalService/2/%@",@(page)];
    return MFURLWithPara(parmUrl);
}

+ (NSString *)classRoomPage:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/classes/2/%@",@(page)];
    return MFURLWithPara(parmUrl);
}

+ (NSString *)hospitals:(NSInteger )type page:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/hospitals/%@/%@",@(type),@(page)];
    return MFURLWithPara(parmUrl);
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

+ (NSString *)productDetail:(NSInteger)pid
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/products/%@",@(pid)];
    return MFURLWithPara(parmUrl);
}

+ (NSString *)products:(NSInteger )cid page:(NSInteger)page
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/products/%@/%@",@(cid),@(page)];
    return MFURLWithPara(parmUrl);
}

//查询用户信息
+ (NSString *)userInfo:(NSString *)telephone
{
    NSString *parmUrl = [NSString stringWithFormat:@"api/users/%@",telephone];
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

+ (NSString *)hostUrl
{
    return test_ServerUrl;
}

@end

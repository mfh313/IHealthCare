//
//  HealthCareApiManger.h
//  IHealthCare
//
//  Created by 马方华 on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HealthCareApiManger : MMNetworkRequest

//查询健康管理详情
+ (NSString *)getHealthControlDetail:(NSInteger)hcid;

//身份认证
+ (NSString *)userAuth;

//查询用户信息
+ (NSString *)userInfo:(NSString *)telephone;

//查询子课程详情
+ (NSString *)subClassesDetail:(NSInteger)crid;

//查询子课程列表
+ (NSString *)subClassesDetail:(NSInteger)crid page:(NSInteger)page;

//查询课程详情
+ (NSString *)classDetail:(NSInteger)pid;

//修改地址
+ (NSString *)modifyOrderAddress:(NSInteger)aid;

//增加订单地址
+ (NSString *)addOrderAddress;

//订单地址列表
+ (NSString *)getUserOrderAddress:(NSString *)tel;

//订单支付
+ (NSString *)payOrder:(NSInteger)oid;

//提交订单
+ (NSString *)createOrder;

//精准分析
+ (NSString *)healthAnalysis:(NSInteger)page;

//专业服务
+ (NSString *)healthMedicalService:(NSInteger)page;

//大讲堂
+ (NSString *)classRoomPage:(NSInteger)page;

+ (NSString *)hospitals:(NSInteger )type page:(NSInteger)page;

//七牛上传图像token
+ (NSString *)upImageToken;

+ (NSString *)healthControls:(NSInteger )type page:(NSInteger)page;

//查询所有前沿资讯
+ (NSString *)bestNews:(NSInteger )type page:(NSInteger)page;

+ (NSString *)productDetail:(NSInteger)pid;

+ (NSString *)products:(NSInteger )cid page:(NSInteger)page;

+ (NSString *)getVerifycode:(NSString *)telephone;

+ (NSString *)userLogin;

@end



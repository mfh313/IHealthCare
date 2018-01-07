//
//  HealthCareApiManger.h
//  IHealthCare
//
//  Created by 马方华 on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HealthCareApiManger : MMNetworkRequest

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

+ (NSString *)products:(NSInteger )cid page:(NSInteger)page;

+ (NSString *)getVerifycode:(NSString *)telephone;

+ (NSString *)userLogin;

@end



//
//  HealthCareApiManger.h
//  IHealthCare
//
//  Created by 马方华 on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HealthCareApiManger : MMNetworkRequest

+ (NSString *)healthAnalysis:(NSInteger)page; //精准分析
+ (NSString *)healthMedicalService:(NSInteger)page; //专业服务
+ (NSString *)classRoomPage:(NSInteger)page;  //大讲堂
+ (NSString *)hospitals:(NSInteger )type page:(NSInteger)page;
+ (NSString *)upImageToken; //七牛上传图像token
+ (NSString *)healthControls:(NSInteger )type page:(NSInteger)page;
+ (NSString *)bestNews:(NSInteger )type page:(NSInteger)page; //查询所有前沿资讯
+ (NSString *)products:(NSInteger )cid page:(NSInteger)page;
+ (NSString *)getVerifycode:(NSString *)telephone;
+ (NSString *)userLogin;

@end



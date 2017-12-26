//
//  HealthCareApiManger.h
//  IHealthCare
//
//  Created by 马方华 on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HealthCareApiManger : MMNetworkRequest

//七牛上传图像token
+ (NSString *)upImageToken;
//查询所有前沿资讯
+ (NSString *)bestNews:(NSInteger )type page:(NSInteger)page;
+ (NSString *)products:(NSInteger )cid page:(NSInteger)page;
+ (NSString *)getVerifycode:(NSString *)telephone;
+ (NSString *)userLogin;

@end

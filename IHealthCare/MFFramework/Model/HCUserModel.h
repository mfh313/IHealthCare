//
//  HCUserModel.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCUserModel : NSObject

@property (nonatomic,strong) NSString *telephone; //手机号码
@property (nonatomic,strong) NSString *name;   //名称
@property (nonatomic,strong) NSString *idNumber;  //身份证号码
@property (nonatomic,strong) NSString *address;  //住址
@property (nonatomic,strong) NSString *bankCardId;  //银行卡号
@property (nonatomic,strong) NSString *company;  //公司
@property (nonatomic,assign) NSInteger level; //1：用戶:2：VIP,3：大客户，4：签约代理商，5：直属代理商，6：合伙人
@property (nonatomic,strong) NSString *preUserphone;  //邀请人手机号码
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,assign) NSInteger sex; //性别，0:男，1:女
@property (nonatomic,strong) NSString *imageUrl;  //图像URL
@property (nonatomic,assign) NSInteger status; //1：未认证，2：认证中，3：已认证，默认是未认证

@end

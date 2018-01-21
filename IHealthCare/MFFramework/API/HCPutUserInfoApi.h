//
//  HCPutUserInfoApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCPutUserInfoApi : MMNetworkRequest

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *telephone;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *idNumber;
@property (nonatomic,strong) NSString *bankCardId;
@property (nonatomic,strong) NSString *company;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *preUserphone;
@property (nonatomic,strong) NSNumber *sex;
@property (nonatomic,strong) NSNumber *age;
@property (nonatomic,strong) NSString *imageUrl;

@end

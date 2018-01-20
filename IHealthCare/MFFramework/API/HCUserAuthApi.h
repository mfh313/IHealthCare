//
//  HCUserAuthApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/19.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCUserAuthApi : MMNetworkRequest

@property (nonatomic,strong) NSString *telephone;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *idNumber;
@property (nonatomic,strong) NSString *idImageUrl;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *bankCardId;
@property (nonatomic,strong) NSString *company;
@property (nonatomic,strong) NSNumber *level;

@end

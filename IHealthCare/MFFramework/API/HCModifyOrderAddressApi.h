//
//  HCModifyOrderAddressApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCModifyOrderAddressApi : MMNetworkRequest

@property (nonatomic,assign) NSInteger aid;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *addr;
@property (nonatomic,strong) NSString *city;

@end

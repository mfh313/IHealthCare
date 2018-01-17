//
//  HCGetUserInfoApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/17.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCGetUserInfoApi : MMNetworkRequest

@property (nonatomic,strong) NSString *telephone;

@end

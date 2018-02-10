//
//  HCRefreshUserTokenApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/29.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCRefreshUserTokenApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *authCode;
@property (nonatomic,strong) NSString *modifyTime;

@end


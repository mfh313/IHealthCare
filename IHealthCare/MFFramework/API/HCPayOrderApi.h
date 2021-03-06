//
//  HCPayOrderApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/6.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"

@interface HCPayOrderApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *authCode;
@property (nonatomic,assign) NSInteger oid;

@end

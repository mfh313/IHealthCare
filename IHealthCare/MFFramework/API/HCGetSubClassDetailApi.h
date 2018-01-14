//
//  HCGetSubClassDetailApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCGetSubClassDetailApi : MMNetworkRequest

@property (nonatomic,assign) NSInteger crid;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *authCode;

@end

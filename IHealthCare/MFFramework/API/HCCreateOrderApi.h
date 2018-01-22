//
//  HCCreateOrderApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/5.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"
#import "HCOrderItemModel.h"

@interface HCCreateOrderApi : MMNetworkRequest

@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *authCode;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *addr;
@property (nonatomic,strong) NSMutableArray<HCOrderItemModel *> *carts;

@end


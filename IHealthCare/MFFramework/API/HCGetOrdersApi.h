//
//  HCGetOrdersApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCGetOrdersApi : MMNetworkRequest

@property (nonatomic,strong) NSString *tel;
@property (nonatomic,assign) NSInteger page;

@end

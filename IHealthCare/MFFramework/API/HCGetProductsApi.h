//
//  HCGetProductsApi.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/16.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

extern NSInteger const PRODUCT_HIGHT_SERVICE;  //高品服务
extern NSInteger const PRODUCT_GENERAL;  //正常产品
extern NSInteger const PRODUCT_CLASS_ROOM;  //大讲堂

@interface HCGetProductsApi : MMNetworkRequest

@property (nonatomic,assign) NSInteger cid;
@property (nonatomic,assign) NSInteger page;

@end


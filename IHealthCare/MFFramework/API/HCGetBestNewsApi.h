//
//  HCGetBestNewsApi.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/17.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

extern NSInteger const BestNews_Type_Default;

@interface HCGetBestNewsApi : MMNetworkRequest

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger page;

@end

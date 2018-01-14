//
//  HCGetSubClassesApi.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCGetSubClassesApi : MMNetworkRequest

@property (nonatomic,assign) NSInteger crid;
@property (nonatomic,assign) NSInteger page;

@end

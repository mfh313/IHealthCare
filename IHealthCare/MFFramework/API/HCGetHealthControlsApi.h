//
//  HCGetHealthControlsApi.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/26.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"


@interface HCGetHealthControlsApi : MMNetworkRequest

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger page;

@end

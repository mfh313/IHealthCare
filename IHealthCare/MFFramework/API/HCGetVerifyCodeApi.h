//
//  HCGetVerifyCodeApi.h
//  IHealthCare
//
//  Created by 马方华 on 2017/12/9.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCGetVerifyCodeApi : MMNetworkRequest

@property (nonatomic,strong) NSString *telephone;

@end

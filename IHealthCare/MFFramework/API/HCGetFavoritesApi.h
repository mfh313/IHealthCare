//
//  HCGetFavoritesApi.h
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCGetFavoritesApi : MMNetworkRequest

@property (nonatomic,strong) NSString *tel;
@property (nonatomic,assign) NSInteger page;

@end

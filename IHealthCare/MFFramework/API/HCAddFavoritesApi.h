//
//  HCAddFavoritesApi.h
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCAddFavoritesApi : MMNetworkRequest

@property (nonatomic,assign) NSInteger favoriteId;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,assign) NSInteger category;

@end

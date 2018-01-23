//
//  HCGetCommentsCidApi.h
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCGetCommentsCidApi : MMNetworkRequest

@property (nonatomic,assign) NSInteger cid;
@property (nonatomic,assign) NSInteger commentedId;
@property (nonatomic,assign) NSInteger page;

@end

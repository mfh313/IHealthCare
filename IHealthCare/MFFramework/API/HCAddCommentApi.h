//
//  HCAddCommentApi.h
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMNetworkRequest.h"

@interface HCAddCommentApi : MMNetworkRequest

@property (nonatomic,assign) NSInteger commentedId;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,assign) NSInteger category;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;

@end

//
//  HCCommentsDetailModel.h
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCUserModel.h"

@interface HCCommentsDetailModel : NSObject

@property (nonatomic,assign) NSInteger recordId;
@property (nonatomic,strong) HCUserModel *user;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,assign) NSInteger category;
@property (nonatomic,assign) NSInteger commentedId;

@end


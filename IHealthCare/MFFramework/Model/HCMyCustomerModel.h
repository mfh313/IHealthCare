//
//  HCMyCustomerModel.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCMyCustomerModel : NSObject

@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger workId;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,assign) NSInteger count;

@end

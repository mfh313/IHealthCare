//
//  HCOrderUserAddressModel.h
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCOrderUserAddressModel : NSObject

@property (nonatomic,assign) NSInteger uid;
@property (nonatomic,assign) NSInteger aid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *addr;
@property (nonatomic,strong) NSString *city;

@end

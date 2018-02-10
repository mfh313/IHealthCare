//
//  HCUserLoginTable.h
//  IHealthCare
//
//  Created by mafanghua on 2018/2/9.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCUserLoginTable : NSObject

@property (nonatomic,strong) NSString *userPhone;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *tokenModifyTime;

@end

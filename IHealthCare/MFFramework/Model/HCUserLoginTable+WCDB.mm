//
//  HCUserLoginTable+WCDB.m
//  IHealthCare
//
//  Created by mafanghua on 2018/2/9.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserLoginTable+WCDB.h"

@implementation HCUserLoginTable (WCDB)

WCDB_IMPLEMENTATION(HCUserLoginTable)

WCDB_SYNTHESIZE(HCUserLoginTable, userPhone)
WCDB_SYNTHESIZE(HCUserLoginTable, token)
WCDB_SYNTHESIZE(HCUserLoginTable, tokenModifyTime)

@end

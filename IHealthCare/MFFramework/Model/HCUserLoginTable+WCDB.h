//
//  HCUserLoginTable+WCDB.h
//  IHealthCare
//
//  Created by mafanghua on 2018/2/9.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserLoginTable.h"
#import <WCDB/WCDB.h>

@interface HCUserLoginTable (WCDB) <WCTTableCoding>

WCDB_PROPERTY(userPhone)
WCDB_PROPERTY(token)
WCDB_PROPERTY(tokenModifyTime)

@end

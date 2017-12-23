//
//  MMTableViewUserInfo.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMTableViewUserInfo.h"

@implementation MMTableViewUserInfo

-(void)addUserInfoValue:(id)value forKey:(NSString *)key
{
    NSParameterAssert(key);
    
    if (!_dicInfo) {
        _dicInfo = [NSMutableDictionary dictionary];
    }
    
    if (value) {
        [_dicInfo setObject:value forKey:key];
    }
}

- (id)getUserInfoValueForKey:(NSString *)key
{
    NSParameterAssert(key);
    
    if (_dicInfo) {
        return [_dicInfo objectForKey:key];
    }
    return nil;
}

@end

//
//  MMTableViewUserInfo.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTableViewUserInfo : NSObject
{
    NSMutableDictionary *_dicInfo;
    id _userInfo;
}

@property (nonatomic,strong) id userInfo;

-(void)addUserInfoValue:(id)value forKey:(NSString *)key;
-(id)getUserInfoValueForKey:(NSString *)key;

@end

//
//  HCBestNewsDetailModel.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/17.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCBestNewsDetailModel.h"

@implementation HCBestNewsDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"newsDescription" : @"description"
             };
}

@end

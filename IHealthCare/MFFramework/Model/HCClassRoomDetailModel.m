//
//  HCClassRoomDetailModel.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCClassRoomDetailModel.h"

@implementation HCClassRoomDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"classRoomDescription" : @"description"
             };
}

@end

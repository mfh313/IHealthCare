//
//  HCMyClassesListModel.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyClassesListModel.h"

@implementation HCMyClassesModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"classDescription" : @"description"
             };
}

@end


#pragma mark - HCMyClassesListModel
@implementation HCMyClassesListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"myClassId" : @"id",
             @"myClassData" : @"myClass"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"myClassData" : [HCMyClassesModel class]};
}

@end

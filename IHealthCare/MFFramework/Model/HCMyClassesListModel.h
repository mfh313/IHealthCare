//
//  HCMyClassesListModel.h
//  IHealthCare
//
//  Created by EEKA on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCMyClassesModel : NSObject

@property (nonatomic,assign) NSInteger crid;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *videoUrl;
@property (nonatomic,strong) NSString *classDescription;
@property (nonatomic,strong) NSString *name;

@end

#pragma mark - HCMyClassesListModel
@interface HCMyClassesListModel : NSObject

@property (nonatomic,assign) NSInteger myClassId;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) HCMyClassesModel *myClassData;

@end

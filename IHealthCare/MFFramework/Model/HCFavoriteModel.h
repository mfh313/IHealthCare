//
//  HCFavoriteModel.h
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCCmsCommonModel.h"

extern NSInteger const HCFavorite_category_1;   //高品服务
extern NSInteger const HCFavorite_category_2;   //健康管理交易类
extern NSInteger const HCFavorite_category_3;   //服务显示类
extern NSInteger const HCFavorite_category_4;   //资讯显示类
extern NSInteger const HCFavorite_category_5;   //大讲堂类

@interface HCFavoriteModel : NSObject

@property (nonatomic,assign) NSInteger favoriteId;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,assign) NSInteger category;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) HCCmsCommonModel *favoriteData;

@end



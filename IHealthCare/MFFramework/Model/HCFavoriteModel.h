//
//  HCFavoriteModel.h
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCCmsCommonModel.h"

@interface HCFavoriteModel : NSObject

@property (nonatomic,assign) NSInteger favoriteId;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,assign) NSInteger category;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) HCCmsCommonModel *favoriteData;

@end

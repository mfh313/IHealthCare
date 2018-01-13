//
//  HCMedicalServiceDetailModel.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCMedicalServiceDetailModel : NSObject

@property (nonatomic,assign) NSInteger mid;
@property (nonatomic,strong) NSString *name;    //名字
@property (nonatomic,strong) NSString *imageUrl; //图片
@property (nonatomic,strong) NSString *webLink;
@property (nonatomic,strong) NSString *country;  //国家
@property (nonatomic,strong) NSString *province; //省份
@property (nonatomic,strong) NSString *city; //城市
@property (nonatomic,strong) NSString *address; //地址
@property (nonatomic,strong) NSString *serviceDescription; //简介
@property (nonatomic,strong) NSString *detail; //详情
@property (nonatomic,assign) NSInteger cid;  //分类
@property (nonatomic,assign) NSInteger level;  //等级
@property (nonatomic,assign) NSInteger follow;  //关注量
@property (nonatomic,assign) NSInteger thumbUp;  //点赞量
@property (nonatomic,strong) NSString *createTime; 

@end

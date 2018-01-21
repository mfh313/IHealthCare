//
//  HCBestNewsDetailModel.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/17.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCBestNewsDetailModel : NSObject

@property (nonatomic,assign) NSInteger bid;
@property (nonatomic,strong) NSString *name; //名字
@property (nonatomic,strong) NSString *newsDescription; //简介
@property (nonatomic,strong) NSString *imageUrl; //缩略图
@property (nonatomic,strong) NSString *author; //作者
@property (nonatomic,strong) NSString *organization; //机构组织
@property (nonatomic,strong) NSString *publishTime; //发布时间
@property (nonatomic,strong) NSString *detail; //详情
@property (nonatomic,assign) NSInteger look; //阅读量
@property (nonatomic,assign) NSInteger thumbUp; //点赞量
@property (nonatomic,strong) NSString *createTime; //创建时间
@property (nonatomic,assign) NSInteger cid;
@property (nonatomic,assign) NSInteger csid;

@end

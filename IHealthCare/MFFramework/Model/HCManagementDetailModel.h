//
//  HCManagementDetailModel.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/22.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const CONTROL_HEALTH;
extern NSInteger const CONTROL_WEALTH;
extern NSInteger const CONTROL_HAPPINESS;

@interface HCManagementDetailModel : NSObject

@property (nonatomic,assign) NSInteger hcid;
@property (nonatomic,strong) NSString *name; //名字
@property (nonatomic,strong) NSString *imageUrl; //图片
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *managerDescription; //简介
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,assign) NSInteger cid;
@property (nonatomic,assign) NSInteger csid;
@property (nonatomic,assign) NSInteger look;
@property (nonatomic,assign) NSInteger follow;  //关注量
@property (nonatomic,assign) NSInteger thumbUp;  //点赞量
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,assign) NSInteger stock;  //库存量
@property (nonatomic,assign) CGFloat marketPrice;  //市场价格
@property (nonatomic,assign) CGFloat shopPrice;    //店内价格
@property (nonatomic,assign) NSInteger isHot;  //是否热卖
@property (nonatomic,assign) CGFloat discount;    //折扣
@property (nonatomic,assign) CGFloat promotionFee;    //推广费
@property (nonatomic,strong) NSString *privilegeTime; //优惠时间
@property (nonatomic,assign) NSInteger sales;  //销量


@end

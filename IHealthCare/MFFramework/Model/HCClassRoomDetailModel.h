//
//  HCClassRoomDetailModel.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCUserModel.h"

@interface HCClassRoomDetailModel : NSObject

@property (nonatomic,assign) NSInteger crid;
@property (nonatomic,strong) NSString *imageUrl; //图片
@property (nonatomic,strong) NSString *videoUrl; 
@property (nonatomic,strong) NSString *name; //课堂标题
@property (nonatomic,strong) NSString *classRoomDescription; //简介特色
@property (nonatomic,strong) NSString *detail; //详情
@property (nonatomic,assign) NSInteger follow;  //关注量
@property (nonatomic,assign) NSInteger thumbUp;  //点赞量
@property (nonatomic,strong) NSString *createTime; //发布时间
@property (nonatomic,assign) NSInteger isFree;  //是否付费，0：免费,1:付费
@property (nonatomic,assign) CGFloat price;  //价格
@property (nonatomic,assign) CGFloat discount;  //折扣
@property (nonatomic,strong) NSString *privilegeTime; //优惠时间
@property (nonatomic,assign) NSInteger sales;  //销量，付费后加1
@property (nonatomic,assign) NSInteger cid;
@property (nonatomic,assign) NSInteger csid;
@property (nonatomic,strong) HCUserModel *user;

@end

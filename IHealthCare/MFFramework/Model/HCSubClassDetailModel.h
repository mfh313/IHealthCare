//
//  HCSubClassDetailModel.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCSubClassDetailModel : NSObject

@property (nonatomic,assign) NSInteger crid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger seqNumber;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *videoUrl;
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,strong) NSString *subClassDescription;
@property (nonatomic,assign) NSInteger watch;
@property (nonatomic,strong) NSString *createTime;

@end

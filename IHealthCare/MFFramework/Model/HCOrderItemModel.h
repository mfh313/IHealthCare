//
//  HCOrderItemModel.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCClassRoomDetailModel.h"
#import "HCManagementDetailModel.h"
#import "HCProductDetailModel.h"

@interface HCOrderItemModel : NSObject

@property (nonatomic,assign) NSInteger pid;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) HCProductDetailModel *detailModel;
@property (nonatomic,strong) HCClassRoomDetailModel *classDetailModel;
@property (nonatomic,strong) HCManagementDetailModel *manageDetailModel;

@end

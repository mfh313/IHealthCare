//
//  HCClassRoomCourseDescriptionViewController.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"

@class HCClassRoomDetailModel;
@interface HCClassRoomCourseDescriptionViewController : MMUIViewController

@property (nonatomic, strong) HCClassRoomDetailModel *detailModel;

-(void)reloadCourseDescription;

@end

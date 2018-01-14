//
//  HCClassRoomCourseSelectionViewController.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"

@class HCClassRoomCourseSelectionViewController,HCSubClassDetailModel;
@protocol HCClassRoomCourseSelectionViewControllerDelegate <NSObject>
@optional
-(void)onSelectClassSubDetal:(HCSubClassDetailModel *)subDetal
            controller:(HCClassRoomCourseSelectionViewController *)controller;

@end

@class HCClassRoomDetailModel;
@interface HCClassRoomCourseSelectionViewController : MMUIViewController

@property (nonatomic,weak) id<HCClassRoomCourseSelectionViewControllerDelegate> m_delegate;
@property (nonatomic, strong) HCClassRoomDetailModel *detailModel;

-(void)reloadCourseSelection;

@end

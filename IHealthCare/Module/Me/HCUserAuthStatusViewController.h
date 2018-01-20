//
//  HCUserAuthStatusViewController.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"
#import "HCUserModel.h"

@class HCUserAuthStatusViewController;
@protocol HCUserAuthStatusViewControllerDelegate <NSObject>
@optional
-(void)onClickReUserAuth:(HCUserAuthStatusViewController *)controller;

@end

@interface HCUserAuthStatusViewController : MMUIViewController

@property (nonatomic,strong) HCUserModel *userInfo;

@property (nonatomic,weak) id<HCUserAuthStatusViewControllerDelegate> m_delegate;

@end

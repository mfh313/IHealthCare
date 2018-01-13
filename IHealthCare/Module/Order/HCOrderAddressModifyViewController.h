//
//  HCOrderAddressModifyViewController.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"
#import "HCOrderUserAddressModel.h"

@class HCOrderAddressModifyViewController;
@protocol HCOrderAddressModifyViewControllerDelegate <NSObject>
@optional
-(void)onModifyAddressInfo:(HCOrderAddressModifyViewController *)controller address:(HCOrderUserAddressModel *)address;

@end

@interface HCOrderAddressModifyViewController : MMUIViewController

@property (nonatomic,strong) HCOrderUserAddressModel *addressInfo;

@property (nonatomic,weak) id<HCOrderAddressModifyViewControllerDelegate> m_delegate;

@end

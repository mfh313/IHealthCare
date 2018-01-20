//
//  HCUserAuthSubmitSuccessViewController.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIViewController.h"

@protocol HCUserAuthSubmitSuccessViewControllerDelegate <NSObject>
@optional
-(void)onClickUserAuthSubmitSuccess;

@end

@interface HCUserAuthSubmitSuccessViewController : MMUIViewController

@property (nonatomic,weak) id<HCUserAuthSubmitSuccessViewControllerDelegate> m_delegate;

@end

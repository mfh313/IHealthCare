//
//  HCLoginContentView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/11/30.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCLoginContentView;
@protocol HCLoginContentViewDelegate <NSObject>
@optional
-(void)onClickGetVerifyCode:(HCLoginContentView *)view;
-(void)onClickForgetPassword:(HCLoginContentView *)view;
-(void)onClickWeChatLogin:(HCLoginContentView *)view;
-(void)onClickQQLogin:(HCLoginContentView *)view;
-(void)onClickLogin:(NSString *)phone verificationCode:(NSString *)verificationCode view:(HCLoginContentView *)view;

@end

@interface HCLoginContentView : MMUIBridgeView

@property (nonatomic,weak) id<HCLoginContentViewDelegate> m_delegate;

-(NSString *)inputPhoneText;
-(void)setVerifyCode:(NSString *)verifyCode;

@end

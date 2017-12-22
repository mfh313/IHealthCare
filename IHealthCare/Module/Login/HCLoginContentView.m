//
//  HCLoginContentView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/11/30.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCLoginContentView.h"

@interface HCLoginContentView ()
{
    __weak IBOutlet UITextField *m_phoneTextField;
    __weak IBOutlet UITextField *m_verificationCodeTextField;
    __weak IBOutlet UIButton *m_sendCodeButton;
    __weak IBOutlet UIButton *m_loginButton;
    __weak IBOutlet UIButton *m_WeChatButton;
    __weak IBOutlet UIButton *m_QQButton;
}

@end

@implementation HCLoginContentView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [m_loginButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [m_loginButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [m_loginButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    
    [m_sendCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [m_sendCodeButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_nor") forState:UIControlStateNormal];
    [m_sendCodeButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_press") forState:UIControlStateHighlighted];
    [m_sendCodeButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_dis") forState:UIControlStateDisabled];
    [m_sendCodeButton addTarget:self action:@selector(onClickGetVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    
    m_phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    m_verificationCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

-(void)onClickGetVerifyCode:(id)sender
{
    [self endEditing:YES];
    if ([self.m_delegate respondsToSelector:@selector(onClickGetVerifyCode:)]) {
        [self.m_delegate onClickGetVerifyCode:self];
    }
}

- (IBAction)onClickLoginBtn:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickLogin:verificationCode:view:)]) {
        [self.m_delegate onClickLogin:m_phoneTextField.text verificationCode:m_verificationCodeTextField.text view:self];
    }
}

- (IBAction)onClickWeChatLogin:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickWeChatLogin:)]) {
        [self.m_delegate onClickWeChatLogin:self];
    }
}

- (IBAction)onClickQQLogin:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickQQLogin:)]) {
        [self.m_delegate onClickQQLogin:self];
    }
}

-(NSString *)inputPhoneText
{
    return m_phoneTextField.text;
}

-(void)setVerifyCode:(NSString *)verifyCode
{
    m_verificationCodeTextField.text = verifyCode;
}

@end

//
//  HCMeProfileAuthStatusCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMeProfileAuthStatusCellView.h"

@implementation HCMeProfileAuthStatusCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAvtarImage];
        [self initNameLabel];
        [self initLevelLabel];
        
        [self initAuthButton];
        [self initAuthedLabel];
        [self initAccessoryImageView];
        
        [m_authButton setHidden:YES];
        [m_authedLabel setHidden:YES];
        
        [self addTarget:self action:@selector(onClickContent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(void)onClickContent:(id)sender
{
    
    if ([self.m_delegate respondsToSelector:@selector(onClickProfileCell:)]) {
        [self.m_delegate onClickProfileCell:self];
    }
    
}

-(void)layoutProfileViews
{
    if ([MFStringUtil isBlankString:self.userInfo.name])
    {
        m_nameLabel.textColor = [UIColor hx_colorWithHexString:@"A5A5A5"];
        m_nameLabel.text = @"未设置姓名";
    }
    else
    {
        m_nameLabel.textColor = [UIColor hx_colorWithHexString:@"000000"];
        m_nameLabel.text = self.userInfo.name;
    }
    
    m_levelLabel.text = [self.userInfo userLevelDescription];
    
    if (self.userInfo.status == HCUserAuthStatus_Authorized)
    {
        [m_authedLabel setHidden:NO];
    }
    else if (self.userInfo.status == HCUserAuthStatus_UnAuthorized)
    {
        [m_authButton setHidden:NO];
        [m_authButton setTitle:@"身份认证" forState:UIControlStateNormal];
    }
    else if (self.userInfo.status == HCUserAuthStatus_Authoring)
    {
        [m_authButton setHidden:NO];
        [m_authButton setTitle:@"认证中..." forState:UIControlStateNormal];
    }
    else if (self.userInfo.status == HCUserAuthStatus_Fail)
    {
        [m_authButton setHidden:NO];
        [m_authButton setTitle:@"认证失败" forState:UIControlStateNormal];
    }
    
    [self makeSubViewsConstraints];
}

-(void)makeSubViewsConstraints
{
    [m_avtarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [m_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_avtarImageView.mas_right).offset(30);
        make.top.mas_equalTo(self.mas_top).offset(42);
        make.height.mas_equalTo(20);
    }];
    
    [m_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(m_avtarImageView.mas_right).offset(30);
        make.top.mas_equalTo(m_nameLabel.mas_bottom).offset(8);
    }];
    
    [m_accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    [m_authedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(m_accessoryImageView.mas_left).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    [m_authButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(m_accessoryImageView.mas_left).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
}

@end

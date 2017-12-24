//
//  HCMeProfileCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCMeProfileCellView.h"

@interface HCMeProfileCellView ()
{
    __weak IBOutlet UIImageView *m_avtarImageView;
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_levelLabel;
    __weak IBOutlet UILabel *m_unLoginLabel;
    __weak IBOutlet UIImageView *m_arrowImageView;
    __weak IBOutlet UILabel *m_authedLabel;
    __weak IBOutlet UIButton *m_authingButton;
    __weak IBOutlet UIButton *m_authButton;
    
}

@end

@implementation HCMeProfileCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_authButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_nor") forState:UIControlStateNormal];
    [m_authButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_press") forState:UIControlStateHighlighted];
    [m_authButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_dis") forState:UIControlStateDisabled];
    [m_authButton addTarget:self action:@selector(onClickToAuthButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [m_authingButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_nor") forState:UIControlStateNormal];
    [m_authingButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_press") forState:UIControlStateHighlighted];
    [m_authingButton setBackgroundImage:MFImageStretchCenter(@"common_btn_code_dis") forState:UIControlStateDisabled];
    [m_authingButton addTarget:self action:@selector(onClickAuthingButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setSubViewHidden];
    
//    [self setUnLoginStatus];
    [self setLoginStatus];
//    [self setAuthingStatus];
//    [self setAuthedStatus];
}

-(void)setSubViewHidden
{
    [m_nameLabel setHidden:YES];
    [m_levelLabel setHidden:YES];
    [m_unLoginLabel setHidden:YES];
    [m_arrowImageView setHidden:YES];
    [m_authedLabel setHidden:YES];
    [m_authingButton setHidden:YES];
    [m_authButton setHidden:YES];
}

-(void)setUnLoginStatus
{
    [m_unLoginLabel setHidden:NO];
}

-(void)setLoginStatus
{
    [m_nameLabel setHidden:NO];
    [m_levelLabel setHidden:NO];
    [m_authButton setHidden:NO];
    [m_arrowImageView setHidden:NO];
}

-(void)setAuthingStatus
{
    [m_nameLabel setHidden:NO];
    [m_levelLabel setHidden:NO];
    [m_authingButton setHidden:NO];
    [m_arrowImageView setHidden:NO];
}

-(void)setAuthedStatus
{
    [m_nameLabel setHidden:NO];
    [m_levelLabel setHidden:NO];
    [m_authedLabel setHidden:NO];
    [m_arrowImageView setHidden:NO];
}

-(void)onClickToAuthButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickToAuth:)]) {
        [self.m_delegate onClickToAuth:self];
    }
}

-(void)onClickAuthingButton:(id)sender
{
    NSLog(@"onClickAuthingButton");
}

- (IBAction)onClickProfileButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickProfileCell:)]) {
        [self.m_delegate onClickProfileCell:self];
    }
}

@end

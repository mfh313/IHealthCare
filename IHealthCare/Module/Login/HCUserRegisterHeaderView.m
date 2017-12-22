//
//  HCUserRegisterHeaderView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/2.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCUserRegisterHeaderView.h"

@interface HCUserRegisterHeaderView ()
{
    __weak IBOutlet UIButton *m_headAvatarButton;
}

@end

@implementation HCUserRegisterHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [m_headAvatarButton setAdjustsImageWhenHighlighted:NO];
}

-(void)setAvatarImage:(UIImage *)image
{
    [m_headAvatarButton setImage:image forState:UIControlStateNormal];
}

- (IBAction)onClickHeadAvatarButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickHeadAvatarButton:)]) {
        [self.m_delegate onClickHeadAvatarButton:self];
    }
}

@end

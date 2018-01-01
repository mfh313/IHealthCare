//
//  HCHealthManagementDetailToolBar.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCHealthManagementDetailToolBar.h"

@interface HCHealthManagementDetailToolBar ()
{
    __weak IBOutlet UIButton *m_praiseButton;
    __weak IBOutlet UIButton *m_messageButton;
    __weak IBOutlet UIView *m_writeBgView;
}

@end

@implementation HCHealthManagementDetailToolBar

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    m_writeBgView.layer.borderWidth = 1.0f;
    m_writeBgView.layer.borderColor = [UIColor hx_colorWithHexString:@"E4E4E4"].CGColor;
    m_writeBgView.layer.cornerRadius = 20.0f;
    
    [m_messageButton setImage:MFImage(@"home_btn_message_nor") forState:UIControlStateNormal];
    [m_messageButton setImage:MFImage(@"home_btn_message_press") forState:UIControlStateHighlighted];
    
    [m_praiseButton setImage:MFImage(@"home_btn_praise_nor") forState:UIControlStateNormal];
    [m_praiseButton setImage:MFImage(@"home_btn_praise_press") forState:UIControlStateHighlighted];
}

- (IBAction)onClickMessageButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickMessageButton:)]) {
        [self.m_delegate onClickMessageButton:self];
    }
}

- (IBAction)onClickPraiseButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickPraiseButton:)]) {
        [self.m_delegate onClickPraiseButton:self];
    }
}

@end

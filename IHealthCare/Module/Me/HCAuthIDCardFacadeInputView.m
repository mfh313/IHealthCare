//
//  HCAuthIDCardFacadeInputView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/24.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCAuthIDCardFacadeInputView.h"

@interface HCAuthIDCardFacadeInputView ()
{
    __weak IBOutlet UIButton *m_contentButton;
}

@end

@implementation HCAuthIDCardFacadeInputView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_contentButton setImage:MFImage(@"my_btn_add_nor") forState:UIControlStateNormal];
    [m_contentButton setImage:MFImage(@"my_btn_add_press") forState:UIControlStateHighlighted];
    [m_contentButton addTarget:self action:@selector(onClickContentButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onClickContentButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickContenButton:)]) {
        [self.m_delegate onClickContenButton:self];
    }
}

@end

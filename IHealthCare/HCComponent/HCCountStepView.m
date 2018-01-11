//
//  HCCountStepView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCountStepView.h"

@interface HCCountStepView ()
{
    __weak IBOutlet UIButton *m_minusButton;
    __weak IBOutlet UIButton *m_addButton;
    __weak IBOutlet UIButton *m_middleButton;
    __weak IBOutlet UILabel *m_countLabel;
    
    
    NSInteger m_count;
}

@end

@implementation HCCountStepView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_minusButton setImage:MFImage(@"home_btn_subtract_nor") forState:UIControlStateNormal];
    [m_minusButton setImage:MFImage(@"home_btn_subtract_press") forState:UIControlStateHighlighted];
    [m_minusButton setImage:MFImage(@"home_btn_subtract_press") forState:UIControlStateDisabled];
    
    [m_addButton setImage:MFImage(@"home_btn_add_nor") forState:UIControlStateNormal];
    [m_addButton setImage:MFImage(@"home_btn_add_press") forState:UIControlStateHighlighted];
    
    [m_middleButton setBackgroundImage:MFImageStretchCenter(@"home_btn_line_press") forState:UIControlStateNormal];
}

-(void)setCurrentCount:(NSInteger)count
{
    m_count = count;
    m_countLabel.text = [NSString stringWithFormat:@"%@",@(m_count)];
}

- (IBAction)onClickMinusButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickMinusButton)]) {
        [self.m_delegate onClickMinusButton];
    }
}

- (IBAction)onClickAddButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickAddButton)]) {
        [self.m_delegate onClickAddButton];
    }
}


@end

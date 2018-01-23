//
//  HCCommentsAddToolBar.m
//  IHealthCare
//
//  Created by EEKA on 2018/1/23.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCommentsAddToolBar.h"

@interface HCCommentsAddToolBar ()
{
    __weak IBOutlet UIView *m_writeBgView;
}

@end

@implementation HCCommentsAddToolBar

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    m_writeBgView.layer.borderWidth = 1.0f;
    m_writeBgView.layer.borderColor = [UIColor hx_colorWithHexString:@"E4E4E4"].CGColor;
    m_writeBgView.layer.cornerRadius = 20.0f;
}

- (IBAction)onClickWriteButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickWriteButton:)]) {
        [self.m_delegate onClickWriteButton:self];
    }
}


@end

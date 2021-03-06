//
//  HCBestNewsDetailToolBar.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/31.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCBestNewsDetailToolBar.h"


@interface HCBestNewsDetailToolBar ()
{
    __weak IBOutlet UIButton *m_collectionButton;
    __weak IBOutlet UIButton *m_praiseButton;
    __weak IBOutlet UIButton *m_messageButton;
    __weak IBOutlet UIView *m_writeBgView;
    __weak IBOutlet UIView *m_praiseView;
    
    HCBadgeView *m_badgeView;
}

@end

@implementation HCBestNewsDetailToolBar

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
    
    [m_collectionButton setImage:MFImage(@"home_btn_collection_nor") forState:UIControlStateNormal];
    [m_collectionButton setImage:MFImage(@"home_btn_collection_press") forState:UIControlStateHighlighted];
    
    m_badgeView = [[HCBadgeView alloc] initWithFrame:CGRectMake(0, 0, 18, 10)];
    [self addSubview:m_badgeView];
    
    [m_badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(m_praiseView.mas_right).offset(0);
        make.top.mas_equalTo(m_praiseView.mas_top).offset(10);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(10);
    }];
}

-(HCBadgeView *)praiseView
{
    return m_badgeView;
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

- (IBAction)onClickCollectionButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickCollectionButton:)]) {
        [self.m_delegate onClickCollectionButton:self];
    }
}

- (IBAction)onClickWriteButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickWriteButton:)]) {
        [self.m_delegate onClickWriteButton:self];
    }
}

@end

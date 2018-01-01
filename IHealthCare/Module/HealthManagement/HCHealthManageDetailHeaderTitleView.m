//
//  HCHealthManageDetailHeaderTitleView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCHealthManageDetailHeaderTitleView.h"
#import "HCManagementDetailModel.h"

@interface HCHealthManageDetailHeaderTitleView ()
{
    __weak IBOutlet UILabel *m_titleLabel;
    __weak IBOutlet UILabel *m_eyeLabel;
    __weak IBOutlet UILabel *m_thumUpLabel;
    __weak IBOutlet UIButton *m_chatButton;
    __weak IBOutlet UIButton *m_eyeButton;
    
    HCManagementDetailModel *m_detailModel;
}

@end

@implementation HCHealthManageDetailHeaderTitleView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_eyeButton setImage:MFImage(@"management_btn_focus_nor") forState:UIControlStateNormal];
    [m_eyeButton setImage:MFImage(@"management_btn_focus_press") forState:UIControlStateHighlighted];
    [m_eyeButton setImage:MFImage(@"management_btn_focus_press") forState:UIControlStateSelected];
}

-(void)setManagementDetail:(HCManagementDetailModel *)itemModel
{
    m_detailModel = itemModel;
    
    m_titleLabel.text = itemModel.name;
    m_eyeLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.follow)];
    m_thumUpLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.thumbUp)];
}

- (IBAction)onClickChatButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickChat:)]) {
        [self.m_delegate onClickChat:m_detailModel];
    }
}

- (IBAction)onClickEyeButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickFollowUp:)]) {
        [self.m_delegate onClickFollowUp:m_detailModel];
    }
}

@end

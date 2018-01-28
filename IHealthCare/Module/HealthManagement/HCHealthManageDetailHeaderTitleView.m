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
    __weak IBOutlet UIButton *m_chatButton;
    __weak IBOutlet UIButton *m_eyeButton;
    
    __weak IBOutlet UILabel *m_salesLabel;
    __weak IBOutlet UILabel *m_promotionFeeLabel;
    __weak IBOutlet UILabel *m_discountLabel;
    __weak IBOutlet UILabel *m_moneyLabel;
    
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
    
    m_salesLabel.text = [NSString stringWithFormat:@"销量  %@",@(itemModel.sales)];
    m_promotionFeeLabel.text = [NSString stringWithFormat:@"推广费  ¥%.2f",itemModel.promotionFee];
    
    NSInteger discount = itemModel.discount * 100;
    m_discountLabel.text = [NSString stringWithFormat:@"折扣 %@%%",@(discount)];
    
    m_moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",itemModel.shopPrice];
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

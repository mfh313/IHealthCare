//
//  HCHealthManagementCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/26.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHealthManagementCellView.h"
#import "HCManagementDetailModel.h"

@interface HCHealthManagementCellView ()
{
    __weak IBOutlet UILabel *m_moneyLabel;
    __weak IBOutlet UILabel *m_salesLabel;
    __weak IBOutlet UILabel *m_promotionFeeLabel;
    __weak IBOutlet UILabel *m_discountLabel;
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_detailLabel;
    __weak IBOutlet UIImageView *m_contentImageView;
    __weak IBOutlet UIView *m_contentView;
    
    HCManagementDetailModel *m_detailModel;
}

@end

@implementation HCHealthManagementCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    
    m_contentView.layer.cornerRadius = 10.0f;
    m_contentView.layer.masksToBounds = YES;
    
    m_contentImageView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setManagementDetail:(HCManagementDetailModel *)itemModel
{
    m_detailModel = itemModel;
    
    [m_contentImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl]];
    
    m_nameLabel.text = itemModel.name;
    m_detailLabel.text = itemModel.managerDescription;
    
    m_moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",itemModel.shopPrice];
    m_salesLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.sales)];
    m_promotionFeeLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.promotionFee)];
    NSInteger discount = itemModel.discount * 100;
    m_discountLabel.text = [NSString stringWithFormat:@"%@%%",@(discount)];
}

- (IBAction)onClickContentButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickShowManagementDetail:)]) {
        [self.m_delegate onClickShowManagementDetail:m_detailModel];
    }
}

@end

//
//  HCProductDetailHeaderTitleView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/30.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCProductDetailHeaderTitleView.h"
#import "HCProductDetailModel.h"

@interface HCProductDetailHeaderTitleView ()
{
    __weak IBOutlet UILabel *m_titleLabel;
    __weak IBOutlet UILabel *m_salesLabel;
    __weak IBOutlet UILabel *m_promotionFeeLabel;
}

@end

@implementation HCProductDetailHeaderTitleView

-(void)setProductDetail:(HCProductDetailModel *)itemModel
{
    m_titleLabel.text = itemModel.pname;
    m_salesLabel.text = [NSString stringWithFormat:@"销量  %@",@(itemModel.sales)];
    m_promotionFeeLabel.text = [NSString stringWithFormat:@"推广费  %.2f",itemModel.promotionFee];
}

@end

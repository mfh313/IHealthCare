//
//  HCHighProductCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/17.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHighProductCellView.h"
#import "HCProductDetailModel.h"

@interface HCHighProductCellView ()
{
    __weak IBOutlet UILabel *m_salesLabel;
    __weak IBOutlet UILabel *m_discountLabel;
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_detailLabel;
    __weak IBOutlet UIImageView *m_contentImageView;
    __weak IBOutlet UIView *m_contentView;
    
    HCProductDetailModel *m_detailModel;
}

@end

@implementation HCHighProductCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    
    m_contentView.layer.cornerRadius = 10.0f;
    m_contentView.layer.masksToBounds = YES;
    
    m_contentImageView.contentMode = UIViewContentModeScaleToFill;
}

-(void)setProductDetail:(HCProductDetailModel *)itemModel
{
    m_detailModel = itemModel;
    
    [m_contentImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.image]];
    
    m_nameLabel.text = itemModel.pname;
    m_detailLabel.text = itemModel.pdesc;
    m_salesLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.sales)];
    
    NSInteger discount = itemModel.discount * 100;
    m_discountLabel.text = [NSString stringWithFormat:@"%@%%",@(discount)];
}

- (IBAction)onClickContentButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickShowProductDetail:)]) {
        [self.m_delegate onClickShowProductDetail:m_detailModel];
    }
}

@end

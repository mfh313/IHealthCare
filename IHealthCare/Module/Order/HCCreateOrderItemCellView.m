//
//  HCCreateOrderItemCellView.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCreateOrderItemCellView.h"
#import "HCProductDetailModel.h"

@interface HCCreateOrderItemCellView ()
{
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_salesLabel;
    __weak IBOutlet UILabel *_promotionLabel;
    __weak IBOutlet UILabel *_moneyLabel;
    
    HCProductDetailModel *m_detailModel;
}

@end

@implementation HCCreateOrderItemCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)setOrderItemCount:(NSInteger)count
{
    
}

-(void)setProductDetail:(HCProductDetailModel *)detailModel
{
    m_detailModel = detailModel;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:m_detailModel.image]];
    _nameLabel.text = m_detailModel.pname;
    _salesLabel.text = [NSString stringWithFormat:@"销量：%@",@(m_detailModel.sales)];
    _promotionLabel.text = [NSString stringWithFormat:@"推广：%@",@(m_detailModel.promotionFee)];
    _moneyLabel.text = [NSString stringWithFormat:@"%.2f",m_detailModel.marketPrice];
}

@end

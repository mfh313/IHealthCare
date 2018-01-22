//
//  HCCreateOrderItemCellView.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCreateOrderItemCellView.h"
#import "HCOrderItemModel.h"
#import "HCCountStepView.h"

@interface HCCreateOrderItemCellView () <HCCountStepViewDelegate>
{
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_salesLabel;
    __weak IBOutlet UILabel *_promotionLabel;
    __weak IBOutlet UILabel *_moneyLabel;
    __weak IBOutlet HCCountStepView *m_stepView;
    
    HCOrderItemModel *m_orderItem;
    HCProductDetailModel *m_detailModel;
}

@end

@implementation HCCreateOrderItemCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    m_stepView.m_delegate = self;
}

-(void)setOrderItemModel:(HCOrderItemModel *)orderItem
{
    m_orderItem = orderItem;
    
    [self setOrderItemCount:orderItem.count];
    [self setProductDetail:orderItem.detailModel];
}

-(void)setOrderItemCount:(NSInteger)count
{
    [m_stepView setCurrentCount:count];
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

#pragma mark - HCCountStepViewDelegate
-(void)onClickMinusButton
{
    if (m_orderItem.count <= 1) {
        return;
    }
    
    m_orderItem.count--;
    [self setOrderItemCount:m_orderItem.count];
}

-(void)onClickAddButton
{
    m_orderItem.count++;
    [self setOrderItemCount:m_orderItem.count];
}

@end

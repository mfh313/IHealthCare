//
//  HCHealthManageCreateOrderItemCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/22.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCHealthManageCreateOrderItemCellView.h"
#import "HCCountStepView.h"
#import "HCProductDetailModel.h"

@interface HCHealthManageCreateOrderItemCellView () <HCCountStepViewDelegate>
{
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_salesLabel;
    __weak IBOutlet UILabel *_promotionLabel;
    __weak IBOutlet UILabel *_moneyLabel;
    __weak IBOutlet HCCountStepView *m_stepView;
    
    HCOrderItemModel *m_orderItem;
    HCManagementDetailModel *m_detailModel;
}

@end

@implementation HCHealthManageCreateOrderItemCellView

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
    [self setProductDetail:orderItem.manageDetailModel];
}

-(void)setOrderItemCount:(NSInteger)count
{
    [m_stepView setCurrentCount:count];
}

-(void)setProductDetail:(HCManagementDetailModel *)detailModel
{
    m_detailModel = detailModel;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:m_detailModel.imageUrl]];
    _nameLabel.text = m_detailModel.name;
    _salesLabel.text = [NSString stringWithFormat:@"销量：%@",@(m_detailModel.sales)];
    _promotionLabel.text = [NSString stringWithFormat:@"点赞：%@",@(m_detailModel.thumbUp)];
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

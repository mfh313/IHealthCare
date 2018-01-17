//
//  HCClassCreateOrderItemCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCClassCreateOrderItemCellView.h"
#import "HCProductDetailModel.h"
#import "HCCountStepView.h"

@interface HCClassCreateOrderItemCellView () <HCCountStepViewDelegate>
{
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_salesLabel;
    __weak IBOutlet UILabel *_promotionLabel;
    __weak IBOutlet UILabel *_moneyLabel;
    __weak IBOutlet HCCountStepView *m_stepView;
    
    HCOrderItemModel *m_orderItem;
    HCClassRoomDetailModel *m_classDetailModel;
}

@end

@implementation HCClassCreateOrderItemCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
//    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    m_stepView.m_delegate = self;
    
}

-(void)setOrderItemModel:(HCOrderItemModel *)orderItem
{
    m_orderItem = orderItem;
    
    [self setOrderItemCount:orderItem.count];
    [self setProductDetail:orderItem.classDetailModel];
}

-(void)setOrderItemCount:(NSInteger)count
{
    [m_stepView setCurrentCount:count];
}

-(void)setProductDetail:(HCClassRoomDetailModel *)detailModel
{
    m_classDetailModel = detailModel;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:m_classDetailModel.imageUrl]];
    _nameLabel.text = m_classDetailModel.name;
    _salesLabel.text = [NSString stringWithFormat:@"销量：%@",@(m_classDetailModel.sales)];
    _promotionLabel.text = [NSString stringWithFormat:@"点赞：%@",@(m_classDetailModel.thumbUp)];
    _moneyLabel.text = [NSString stringWithFormat:@"%.2f",m_classDetailModel.price];
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

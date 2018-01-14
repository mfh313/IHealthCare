//
//  HCClassCreateOrderItemCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCClassCreateOrderItemCellView.h"
#import "HCProductDetailModel.h"

@interface HCClassCreateOrderItemCellView ()
{
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_salesLabel;
    __weak IBOutlet UILabel *_promotionLabel;
    __weak IBOutlet UILabel *_moneyLabel;
    
    HCOrderItemModel *m_orderItem;
    HCClassRoomDetailModel *m_classDetailModel;
}

@end

@implementation HCClassCreateOrderItemCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

-(void)setOrderItemModel:(HCOrderItemModel *)orderItem
{
    m_orderItem = orderItem;
    
    [self setProductDetail:orderItem.classDetailModel];
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

@end

//
//  HCHealthManagementClassRoomCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHealthManagementClassRoomCellView.h"
#import "HCClassRoomDetailModel.h"

@interface HCHealthManagementClassRoomCellView ()
{
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_detailLabel;
    __weak IBOutlet UIImageView *m_contentImageView;
    __weak IBOutlet UIView *m_contentView;
    __weak IBOutlet UILabel *m_salesLabel;
    __weak IBOutlet UILabel *m_promotionFeeLabel;
    __weak IBOutlet UILabel *m_discountLabel;
    __weak IBOutlet UILabel *m_moneyLabel;
    
    HCClassRoomDetailModel *m_detailModel;
}

@end

@implementation HCHealthManagementClassRoomCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    
    m_contentView.layer.cornerRadius = 10.0f;
    m_contentView.layer.masksToBounds = YES;
    
    m_contentImageView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setClassRoomDetail:(HCClassRoomDetailModel *)itemModel
{
    m_detailModel = itemModel;
    
    [m_contentImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl]];
    
    m_nameLabel.text = itemModel.name;
    m_detailLabel.text = itemModel.classRoomDescription;
    m_salesLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.sales)];
    m_promotionFeeLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.promotionFee)];
    
    NSInteger discount = itemModel.discount * 100;
    m_discountLabel.text = [NSString stringWithFormat:@"%@%%",@(discount)];
    m_moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",itemModel.price];
}

- (IBAction)onClickContentButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickClassRoomDetail:)]) {
        [self.m_delegate onClickClassRoomDetail:m_detailModel];
    }
}

@end

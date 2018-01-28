//
//  HCClassRoomCourseDetailHeaderTitleView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/28.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCClassRoomCourseDetailHeaderTitleView.h"
#import "HCClassRoomDetailModel.h"

@interface HCClassRoomCourseDetailHeaderTitleView ()
{
    __weak IBOutlet UILabel *m_salesLabel;
    __weak IBOutlet UILabel *m_promotionFeeLabel;
    __weak IBOutlet UILabel *m_discountLabel;
    __weak IBOutlet UILabel *m_moneyLabel;
    
}

@end

@implementation HCClassRoomCourseDetailHeaderTitleView

-(void)setClassRoomDetailModel:(HCClassRoomDetailModel *)itemModel
{
    m_salesLabel.text = [NSString stringWithFormat:@"销量  %@",@(itemModel.sales)];
    m_promotionFeeLabel.text = [NSString stringWithFormat:@"推广费  ¥%.2f",itemModel.promotionFee];
    
    NSInteger discount = itemModel.discount * 100;
    m_discountLabel.text = [NSString stringWithFormat:@"折扣 %@%%",@(discount)];
    
    m_moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",itemModel.price];
}


@end

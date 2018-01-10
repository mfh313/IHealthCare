//
//  HCMedicalServiceDetailHeaderTitleView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMedicalServiceDetailHeaderTitleView.h"
#import "HCMedicalServiceDetailModel.h"

@interface HCMedicalServiceDetailHeaderTitleView ()
{
    __weak IBOutlet UILabel *m_titleLabel;
    __weak IBOutlet UILabel *m_eyeLabel;
    __weak IBOutlet UILabel *m_thumUpLabel;
    
    HCMedicalServiceDetailModel *m_detailModel;
}

@end

@implementation HCMedicalServiceDetailHeaderTitleView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
}

-(void)setMedicalService:(HCMedicalServiceDetailModel *)itemModel
{
    m_detailModel = itemModel;
    
    m_titleLabel.text = itemModel.name;
    m_eyeLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.follow)];
    m_thumUpLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.thumbUp)];
}

@end

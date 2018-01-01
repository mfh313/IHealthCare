//
//  HCHealthMedicalServiceCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/27.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHealthMedicalServiceCellView.h"
#import "HCMedicalServiceDetailModel.h"

@interface HCHealthMedicalServiceCellView ()
{
    __weak IBOutlet UILabel *m_thumUpLabel;
    __weak IBOutlet UILabel *m_eyeLabel;
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_detailLabel;
    __weak IBOutlet UIImageView *m_contentImageView;
    __weak IBOutlet UIView *m_contentView;
    
    HCMedicalServiceDetailModel *m_detailModel;
}

@end

@implementation HCHealthMedicalServiceCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    
    m_contentView.layer.cornerRadius = 10.0f;
    m_contentView.layer.masksToBounds = YES;
    
    m_contentImageView.contentMode = UIViewContentModeScaleToFill;
}

-(void)setMedicalService:(HCMedicalServiceDetailModel *)itemModel
{
    m_detailModel = itemModel;
    
    [m_contentImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl]];
    
    m_nameLabel.text = itemModel.name;
    m_detailLabel.text = itemModel.serviceDescription;
    m_eyeLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.follow)];
    m_thumUpLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.thumbUp)];
}

- (IBAction)onClickContentButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickShowMedicalService:)]) {
        [self.m_delegate onClickShowMedicalService:m_detailModel];
    }
}

@end

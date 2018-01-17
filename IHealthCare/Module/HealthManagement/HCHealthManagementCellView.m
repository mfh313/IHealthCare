//
//  HCHealthManagementCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/26.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHealthManagementCellView.h"
#import "HCManagementDetailModel.h"

@interface HCHealthManagementCellView ()
{
    __weak IBOutlet UILabel *m_thumUpLabel;
    __weak IBOutlet UILabel *m_eyeLabel;
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_detailLabel;
    __weak IBOutlet UIImageView *m_contentImageView;
    __weak IBOutlet UIView *m_contentView;
    
    HCManagementDetailModel *m_detailModel;
}

@end

@implementation HCHealthManagementCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    
    m_contentView.layer.cornerRadius = 10.0f;
    m_contentView.layer.masksToBounds = YES;
    
    m_contentImageView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setManagementDetail:(HCManagementDetailModel *)itemModel
{
    m_detailModel = itemModel;
    
    [m_contentImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl]];
    
    m_nameLabel.text = itemModel.name;
    m_detailLabel.text = itemModel.managerDescription;
    m_eyeLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.follow)];
    m_thumUpLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.thumbUp)];
}

- (IBAction)onClickContentButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickShowManagementDetail:)]) {
        [self.m_delegate onClickShowManagementDetail:m_detailModel];
    }
}

@end

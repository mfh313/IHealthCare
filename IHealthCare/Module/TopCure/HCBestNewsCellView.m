//
//  HCBestNewsCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/17.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCBestNewsCellView.h"
#import "HCBestNewsDetailModel.h"

@interface HCBestNewsCellView ()
{
    __weak IBOutlet UILabel *m_nameLabel;
    __weak IBOutlet UILabel *m_descriptionLabel;
    __weak IBOutlet UILabel *m_publishTimeLabel;
    __weak IBOutlet UILabel *m_lookLabel;
    __weak IBOutlet UILabel *m_thumbUpLabel;
    __weak IBOutlet UIImageView *m_contentImageView;
    __weak IBOutlet UIView *m_contentView;
    
    HCBestNewsDetailModel *m_detailModel;
}

@end

@implementation HCBestNewsCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    
    m_contentView.layer.cornerRadius = 10.0f;
    m_contentView.layer.masksToBounds = YES;
    
    m_contentImageView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setNewsDetail:(HCBestNewsDetailModel *)itemModel
{
    m_detailModel = itemModel;
    
    [m_contentImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl]];
    
    m_nameLabel.text = itemModel.name;
    m_descriptionLabel.text = itemModel.newsDescription;
    m_publishTimeLabel.text = itemModel.publishTime;
    m_lookLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.look)];
    m_thumbUpLabel.text = [NSString stringWithFormat:@"%@",@(itemModel.thumbUp)];
}

- (IBAction)onClickContentButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickShowNewsDetail:)]) {
        [self.m_delegate onClickShowNewsDetail:m_detailModel];
    }
}

@end

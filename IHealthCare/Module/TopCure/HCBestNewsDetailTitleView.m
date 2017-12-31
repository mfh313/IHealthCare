//
//  HCBestNewsDetailTitleView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/31.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCBestNewsDetailTitleView.h"
#import "HCBestNewsDetailModel.h"

@interface HCBestNewsDetailTitleView ()
{
    __weak IBOutlet UILabel *m_titleLabel;
    __weak IBOutlet UILabel *m_authorLabel;
    __weak IBOutlet UILabel *m_organizationLabel;
    __weak IBOutlet UILabel *m_createTimeLabel;
}

@end

@implementation HCBestNewsDetailTitleView

-(void)setNewsDetail:(HCBestNewsDetailModel *)itemModel
{
    m_titleLabel.text = itemModel.name;
    m_authorLabel.text = itemModel.author;
    m_organizationLabel.text = itemModel.organization;
    m_createTimeLabel.text = itemModel.createTime;
}

@end

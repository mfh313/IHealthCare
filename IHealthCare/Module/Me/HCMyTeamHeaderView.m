//
//  HCMyTeamHeaderView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyTeamHeaderView.h"
#import "HCGetUserInfoApi.h"
#import "HCUserModel.h"

@interface HCMyTeamHeaderView ()
{
    __weak IBOutlet UIImageView *m_imageView;
    __weak IBOutlet UILabel *m_titleLabel;
    __weak IBOutlet UILabel *m_subTitleLabel;
    __weak IBOutlet UILabel *m_levelLabel;
    
    HCUserModel *m_useInfo;
}

@end

@implementation HCMyTeamHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:m_imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:m_imageView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = m_imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    m_imageView.layer.mask = maskLayer;
    
    [self getUserInfo];
}

-(void)getUserInfo
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCGetUserInfoApi *mfApi = [HCGetUserInfoApi new];
    mfApi.userTel = loginService.userPhone;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            return;
        }
        
        NSDictionary *responseNetworkData = mfApi.responseNetworkData;
        
        m_useInfo = [HCUserModel yy_modelWithDictionary:responseNetworkData];
        
        [strongSelf setViewsInfo];
        
    } failure:^(YTKBaseRequest * request) {

    }];
}

-(void)setViewsInfo
{
    [self setImageUrl:m_useInfo.imageUrl];
    m_titleLabel.text = m_useInfo.name;
    m_levelLabel.text = m_useInfo.userLevelDescription;
}

-(void)setImageUrl:(NSString *)imageUrl
{
    [m_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setSubTitle:(NSString *)subTitle
{
    m_subTitleLabel.text = subTitle;
}

@end

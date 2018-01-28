//
//  HCMeProfileCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/15.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCUserModel.h"

@class HCMeProfileCellView;
@protocol HCMeProfileCellViewDelegate <NSObject>
@optional
-(void)onClickToAuth:(HCMeProfileCellView *)view;
-(void)onClickShowAuthStatus:(HCUserModel *)userInfo view:(HCMeProfileCellView *)view;
-(void)onClickProfileCell:(HCMeProfileCellView *)view;

@end

@interface HCMeProfileCellView : UIControl
{
    UIImageView *m_avtarImageView;
    UILabel *m_unLoginLabel;
    
    UILabel *m_nameLabel;
    UILabel *m_levelLabel;
    UILabel *m_authedLabel;
    UIButton *m_authButton;
    
    UIImageView *m_accessoryImageView;
}

@property (nonatomic,weak) id<HCMeProfileCellViewDelegate> m_delegate;
@property (nonatomic,strong) HCUserModel *userInfo;

-(void)initAvtarImage;
-(void)initUnloginLabel;
-(void)initNameLabel;
-(void)initLevelLabel;
-(void)initAuthedLabel;
-(void)initAuthButton;
-(void)initAccessoryImageView;
-(void)layoutProfileViews;
-(void)setAvtarImageUrl:(NSString *)url;

@end

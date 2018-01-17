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
-(void)onClickProfileCell:(HCMeProfileCellView *)view;

@end

@interface HCMeProfileCellView : UIControl
{
    UIImageView *m_avtarImageView;
    UILabel *m_unLoginLabel;
}

@property (nonatomic,weak) id<HCMeProfileCellViewDelegate> m_delegate;
@property (nonatomic,strong) HCUserModel *userInfo;

-(void)initAvtarImage;
-(void)initUnloginLabel;
-(void)layoutProfileViews;

@end

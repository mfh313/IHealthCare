//
//  HCUserAuthLevelSelectView.h
//  IHealthCare
//
//  Created by EEKA on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCUserAuthLevelSelectView;
@protocol HCUserAuthLevelSelectViewDelegate <NSObject>
@optional

-(void)didSelectLevel:(NSInteger)level cellView:(HCUserAuthLevelSelectView *)cellView;

@end

@interface HCUserAuthLevelSelectView : UIView
{
    UILabel *m_titleLabel;
}

@property (nonatomic,weak) id<HCUserAuthLevelSelectViewDelegate> m_delegate;

-(void)setCurrentLevel:(NSInteger)level;

@end

//
//  HCScrollBannerCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/2/9.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCScrollBannerCellView;

@protocol HCScrollBannerCellViewDataSource <NSObject>

@required
-(NSArray *)imagesURLStringsScrollView:(HCScrollBannerCellView *)cycleScrollView;

@end

@protocol HCScrollBannerCellViewDelegate <NSObject>
@optional
-(void)onClickScrollView:(HCScrollBannerCellView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface HCScrollBannerCellView : UIView

@property (nonatomic,weak) id<HCScrollBannerCellViewDataSource> m_dataSource;
@property (nonatomic,weak) id<HCScrollBannerCellViewDelegate> m_delegate;

-(void)reloadBanner;

@end

//
//  HealthCareCenterMenuItemView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HealthCareCenterMenuItemView;
@protocol HealthCareCenterMenuItemViewDataSource <NSObject>
@optional

-(NSString *)normalImageItemView:(HealthCareCenterMenuItemView *)itemView index:(NSInteger )index;
-(NSString *)highlightedImageItemView:(HealthCareCenterMenuItemView *)itemView index:(NSInteger )index;
-(NSString *)menuTitleItemView:(HealthCareCenterMenuItemView *)itemView index:(NSInteger )index;
-(CGFloat)topMarginItemView:(HealthCareCenterMenuItemView *)itemView index:(NSInteger )index;

@end


@protocol HealthCareCenterMenuItemViewDelegate <NSObject>
@optional

-(void)onClickMenuItemView:(HealthCareCenterMenuItemView *)itemView index:(NSInteger )index;

@end

@interface HealthCareCenterMenuItemView : MMUIBridgeView

@property (nonatomic,weak) id<HealthCareCenterMenuItemViewDataSource> m_dataSource;
@property (nonatomic,weak) id<HealthCareCenterMenuItemViewDelegate> m_delegate;
@property (nonatomic,assign) NSInteger index;

-(void)layoutMenuView;

@end

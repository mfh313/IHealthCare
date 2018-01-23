//
//  HCFavoritesCellView.h
//  IHealthCare
//
//  Created by 马方华 on 2018/1/21.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCFavoritesCellView;
@protocol HCFavoritesCellViewDelegate <NSObject>
@optional

-(void)onClickDeleteFavoritesCell:(HCFavoritesCellView *)cellView dataIndex:(NSInteger)index;

@end

@interface HCFavoritesCellView : MMUIBridgeView

@property (nonatomic,weak) id<HCFavoritesCellViewDelegate> m_delegate;
@property (nonatomic,assign) NSInteger index;

-(void)setImageUrl:(NSString *)imageUrl;
-(void)setTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end

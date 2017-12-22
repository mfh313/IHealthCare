//
//  HCBestNewsCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/17.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCBestNewsDetailModel;
@protocol HCBestNewsCellViewDelegate <NSObject>
@optional
-(void)onClickShowNewsDetail:(HCBestNewsDetailModel *)itemModel;

@end

@interface HCBestNewsCellView : MMUIBridgeView

@property (nonatomic,weak) id<HCBestNewsCellViewDelegate> m_delegate;

-(void)setNewsDetail:(HCBestNewsDetailModel *)itemModel;

@end

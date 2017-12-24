//
//  HCAuthIDCardFacadeInputView.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/24.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@class HCAuthIDCardFacadeInputView;
@protocol HCAuthIDCardFacadeInputViewDelegate <NSObject>
@optional
-(void)onClickContenButton:(HCAuthIDCardFacadeInputView *)view;

@end

@interface HCAuthIDCardFacadeInputView : MMUIBridgeView

@property (nonatomic,weak) id<HCAuthIDCardFacadeInputViewDelegate> m_delegate;

@end

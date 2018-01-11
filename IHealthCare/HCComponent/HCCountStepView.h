//
//  HCCountStepView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol HCCountStepViewDelegate <NSObject>
@optional
-(void)onClickMinusButton;
-(void)onClickAddButton;

@end

@interface HCCountStepView : MMUIBridgeView

@property (nonatomic,weak) id<HCCountStepViewDelegate> m_delegate;

-(void)setCurrentCount:(NSInteger)count;

@end

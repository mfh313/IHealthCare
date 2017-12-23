//
//  HCHighProductDetailBottomView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHighProductDetailBottomView.h"

@implementation HCHighProductDetailBottomView

- (IBAction)onClickBuyButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickBuyProduct)]) {
        [self.m_delegate onClickBuyProduct];
    }
}

- (IBAction)onClickCollectionButton:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickCollectionProduct)]) {
        [self.m_delegate onClickCollectionProduct];
    }
}

@end

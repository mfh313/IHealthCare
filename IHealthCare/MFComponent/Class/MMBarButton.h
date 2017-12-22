//
//  MMBarButton.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/2.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMBarButton : UIButton
{
    CGFloat iContentWidth;
    CGFloat iContentHight;
    CGFloat iOriginWidth;
    CGFloat iOriginHeight;
    NSInteger eBarButtonStyle;
}

-(CGRect)backgroundRectForBounds:(CGRect)bounds;

@end

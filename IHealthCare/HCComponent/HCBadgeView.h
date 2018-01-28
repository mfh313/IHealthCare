//
//  HCBadgeView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/28.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCBadgeView : UIView
{
    UILabel *m_contentLabel;
}

-(void)setBadgeCount:(NSInteger)count;

@end

//
//  HCUserAuthLevelSelectItemView.h
//  IHealthCare
//
//  Created by EEKA on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCUserAuthLevelSelectItemView : UIControl
{
    UIImageView *m_imageView;
    UILabel *m_titleLabel;
}

@property (nonatomic,assign) NSInteger attchValue;

-(void)setItemTitle:(NSString *)title;

@end

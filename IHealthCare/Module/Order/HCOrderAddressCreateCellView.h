//
//  HCOrderAddressCreateCellView.h
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIView.h"

@interface HCOrderAddressCreateCellView : MMUIView
{
    UILabel *m_titleLabel;
}

@property (nonatomic,strong) NSString *cellKey;
@property (nonatomic,strong) NSString *leftTitle;

-(void)initSubViews;
-(void)initLeftTitleView;
-(void)layoutContentViews;

@end

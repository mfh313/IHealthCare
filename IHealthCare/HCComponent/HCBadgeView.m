//
//  HCBadgeView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/28.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCBadgeView.h"

@implementation HCBadgeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        
        m_contentLabel = [[UILabel alloc] init];
        m_contentLabel.textColor = [UIColor whiteColor];
        m_contentLabel.font = [UIFont systemFontOfSize:8];
        m_contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:m_contentLabel];
        
        [m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.width.mas_equalTo(self.mas_width);
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.height.mas_equalTo(self.mas_height);
        }];
        
        self.backgroundColor = [UIColor hx_colorWithHexString:@"FF6F6F"];
    }
    
    return self;
}

-(void)setBadgeCount:(NSInteger)count
{
    m_contentLabel.text = [NSString stringWithFormat:@"%@",@(count)];
}

@end

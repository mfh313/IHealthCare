//
//  HCScrollBannerCellView.m
//  IHealthCare
//
//  Created by mafanghua on 2018/2/9.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCScrollBannerCellView.h"
#import <SDCycleScrollView.h>

@interface HCScrollBannerCellView () <SDCycleScrollViewDelegate>
{
    SDCycleScrollView *m_cycleScrollView;
}

@end

@implementation HCScrollBannerCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        m_cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame delegate:self placeholderImage:nil];
        m_cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        m_cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        m_cycleScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:m_cycleScrollView];
    }
    
    return self;
}

-(void)reloadBanner
{
    m_cycleScrollView.imageURLStringsGroup = [self.m_dataSource imagesURLStringsScrollView:self];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.m_delegate respondsToSelector:@selector(onClickScrollView:didSelectItemAtIndex:)]) {
        [self.m_delegate onClickScrollView:self didSelectItemAtIndex:index];
    }
}

@end

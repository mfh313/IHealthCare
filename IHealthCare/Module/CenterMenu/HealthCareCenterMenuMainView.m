//
//  HealthCareCenterMenuMainView.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HealthCareCenterMenuMainView.h"
#import "HealthCareCenterMenuItemView.h"

@interface HealthCareCenterMenuMainView () <HealthCareCenterMenuItemViewDataSource,HealthCareCenterMenuItemViewDelegate>
{
    __weak IBOutlet UIButton *m_closeBtn;
    
    __weak IBOutlet HealthCareCenterMenuItemView *m_myActionView;
    
    NSMutableArray<HealthCareCenterMenuItemView *> *m_actionView;
    NSMutableArray<NSMutableDictionary *> *m_menuInfos;
}

@end

@implementation HealthCareCenterMenuMainView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [m_closeBtn setImage:MFImage(@"common_btn_close_nor") forState:UIControlStateNormal];
    [m_closeBtn setImage:MFImage(@"common_btn_close_press") forState:UIControlStateHighlighted];
    [m_closeBtn addTarget:self action:@selector(onClickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    m_menuInfos = [self menuInfos];
    
    [self layoutMenuActionViews];
}

-(void)onClickCloseButton:(id)sender
{
    if ([self.m_delegate respondsToSelector:@selector(onClickCloseButton:)]) {
        [self.m_delegate onClickCloseButton:self];
    }
}

-(void)layoutMenuActionViews
{
    m_myActionView.m_dataSource = self;
    m_myActionView.m_delegate = self;
    [m_myActionView layoutMenuView];
}

#pragma mark - HealthCareCenterMenuItemViewDataSource
-(NSString *)normalImageItemView:(HealthCareCenterMenuItemView *)itemView index:(NSInteger )index
{
    NSMutableDictionary *menuInfo = m_menuInfos[index];
    return menuInfo[@"normalImage"];
}

-(NSString *)highlightedImageItemView:(HealthCareCenterMenuItemView *)itemView index:(NSInteger )index
{
    NSMutableDictionary *menuInfo = m_menuInfos[index];
    return menuInfo[@"highlightedImage"];
}

-(NSString *)menuTitleItemView:(HealthCareCenterMenuItemView *)itemView index:(NSInteger )index
{
    NSMutableDictionary *menuInfo = m_menuInfos[index];
    return menuInfo[@"title"];
}

#pragma mark - HealthCareCenterMenuItemViewDelegate
-(void)onClickMenuItemView:(HealthCareCenterMenuItemView *)itemView index:(NSInteger )index
{
    if ([self.m_delegate respondsToSelector:@selector(onClickShowMyInfo:)]) {
        [self.m_delegate onClickShowMyInfo:self];
    }
}

-(NSMutableArray<NSMutableDictionary *> *)menuInfos
{
    NSMutableArray *menuInfos = [NSMutableArray array];
    
    NSMutableDictionary *myInfo = [NSMutableDictionary dictionary];
    myInfo[@"normalImage"] = @"common_btn_my_nor";
    myInfo[@"highlightedImage"] = @"common_btn_my_press";
    myInfo[@"title"] = @"用户中心";

    [menuInfos addObject:myInfo];
    return menuInfos;
}

@end

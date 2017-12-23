//
//  MMTableViewSectionInfo.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMTableViewUserInfo.h"

@class MMTableViewCellInfo;
@interface MMTableViewSectionInfo : MMTableViewUserInfo
{
    SEL _makeHeaderSel;
    __weak id _makeHeaderTarget;
    SEL _makeFooterSel;
    __weak id _makeFooterTarget;
    CGFloat _fHeaderHeight;
    CGFloat _fFooterHeight;
    NSMutableArray *_arrCells;
    BOOL _bUseDynamicSize;
}

@property (nonatomic, assign) CGFloat fHeaderHeight;
@property (nonatomic, assign) CGFloat fFooterHeight;
@property (nonatomic, weak) id makeHeaderTarget;
@property (nonatomic, weak) id makeFooterTatget;
@property (nonatomic, assign) SEL makeHeaderSel;
@property (nonatomic, assign) SEL makeFooterSel;
@property (nonatomic, assign) BOOL bUseDynamicSize;

+ (instancetype)sectionInfoDefault;
+ (instancetype)sectionInfoHeader:(NSString *)headerTitle;
+ (instancetype)sectionInfoFooter:(NSString *)footerTitle;
+ (instancetype)sectionInfoHeader:(NSString *)headerTitle footer:(NSString *)footerTitle;
+ (instancetype)sectionInfoHeaderWithView:(UIView *)headerView;
+ (instancetype)sectionInfoFooterWithView:(UIView *)footerView;
+ (instancetype)sectionInfoHeaderMakeSel:(SEL)sel makeTarget:(id)target;

- (void)setHeaderTitle:(NSString *)headerTitle;
- (void)setFooterTitle:(NSString *)footerTitle;
- (void)setHeaderView:(UIView *)headerView;
- (void)setFooterView:(UIView *)footerView;
- (__kindof UIView *)getHeaderView;
- (__kindof UIView *)getFooterView;

- (NSUInteger)getCellCount;
- (MMTableViewCellInfo *)getCellAt:(NSUInteger)row;
- (void)removeCellAt:(NSUInteger)row;
- (void)addCell:(MMTableViewCellInfo *)cell;

@end

//
//  MMTableViewSectionInfo.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMTableViewSectionInfo.h"
#import "MMTableViewCellInfo.h"

@implementation MMTableViewSectionInfo

+ (instancetype)sectionInfoDefault
{
    return [[MMTableViewSectionInfo alloc] init];
}

+ (instancetype)sectionInfoHeader:(NSString *)headerTitle
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerTitle forKey:@"headerTitle"];
    if (headerTitle.length) {
        [sectionInfo setFHeaderHeight:-1.0f];
    }
    return sectionInfo;
}

+ (instancetype)sectionInfoFooter:(NSString *)footerTitle
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:footerTitle forKey:@"footerTitle"];
    if (footerTitle.length) {
        [sectionInfo setFFooterHeight:-1.0f];
    }
    return sectionInfo;
}

+ (instancetype)sectionInfoHeader:(NSString *)headerTitle footer:(NSString *)footerTitle
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerTitle forKey:@"headerTitle"];
    if (headerTitle.length) {
        [sectionInfo setFHeaderHeight:-1.0f];
    }
    [sectionInfo addUserInfoValue:footerTitle forKey:@"footerTitle"];
    if (footerTitle.length) {
        [sectionInfo setFFooterHeight:-1.0f];
    }
    return sectionInfo;
}

+ (instancetype)sectionInfoHeaderWithView:(UIView *)headerView
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerView forKey:@"header"];
    [sectionInfo setFHeaderHeight:headerView.frame.size.height];
    return sectionInfo;
}

+ (instancetype)sectionInfoFooterWithView:(UIView *)footerView
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:footerView forKey:@"footer"];
    [sectionInfo setFFooterHeight:footerView.frame.size.height];
    return sectionInfo;
}

+ (instancetype)sectionInfoHeaderMakeSel:(SEL)sel makeTarget:(id)target
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    [sectionInfo setMakeHeaderSel:sel];
    [sectionInfo setMakeHeaderTarget:target];
    return sectionInfo;
}

- (instancetype)init
{
    if (self = [super init]) {
        _makeHeaderSel = nil;
        _makeFooterSel = nil;
        _fHeaderHeight = 0;
        _fFooterHeight = 0;
        _arrCells = @[].mutableCopy;
    }
    return self;
}

- (void)setHeaderTitle:(NSString *)headerTitle
{
    [self addUserInfoValue:headerTitle forKey:@"headerTitle"];
    if (headerTitle.length) {
        [self setFHeaderHeight:-1.0f];
    }
}

- (void)setFooterTitle:(NSString *)footerTitle
{
    [self addUserInfoValue:footerTitle forKey:@"footerTitle"];
    if (footerTitle.length) {
        [self setFFooterHeight:-1.0f];
    }
}

- (void)setHeaderView:(UIView *)headerView
{
    [self addUserInfoValue:headerView forKey:@"header"];
    [self setFHeaderHeight:headerView.frame.size.height];
}

- (void)setFooterView:(UIView *)footerView
{
    [self addUserInfoValue:footerView forKey:@"footer"];
    [self setFFooterHeight:footerView.frame.size.height];
}

- (UIView *)getHeaderView
{
    return [self getUserInfoValueForKey:@"header"];
}

- (UIView *)getFooterView
{
    return [self getUserInfoValueForKey:@"footer"];
}

- (NSUInteger)getCellCount
{
    return _arrCells.count;
}

- (MMTableViewCellInfo *)getCellAt:(NSUInteger)row
{
    if (_arrCells.count >= row) {
        return _arrCells[row];
    } else {
        return nil;
    }
}

- (void)addCell:(MMTableViewCellInfo *)cell
{
    [_arrCells addObject:cell];
}

- (void)removeCellAt:(NSUInteger)row
{
    [_arrCells removeObjectAtIndex:row];
}

@end

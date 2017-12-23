//
//  MMTableViewInfo.h
//  IHealthCare
//
//  Created by mafanghua on 2017/12/23.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "MMTableViewUserInfo.h"
#import "MMTableViewCellInfo.h"
#import "MMTableViewSectionInfo.h"


@protocol MMTableViewInfoDelegate <NSObject, UIScrollViewDelegate, tableViewDelegate>

@optional
- (void)commitEditingForRowAtIndexPath:(NSIndexPath *)indexPath cell:(MMTableViewCellInfo *)cellInfo;
- (void)accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath cell:(MMTableViewCellInfo *)cellInfo;

@end

@interface MMTableViewInfo : MMTableViewUserInfo <UITableViewDataSource,UITableViewDelegate,tableViewDelegate>
{
    MFUITableView *_tableView;
    NSMutableArray<MMTableViewSectionInfo *> *_arrSections;
    __weak id<MMTableViewInfoDelegate> _delegate;
}


@end

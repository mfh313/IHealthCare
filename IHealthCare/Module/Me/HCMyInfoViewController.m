//
//  HCMyInfoViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyInfoViewController.h"
#import "HCMyInfoAvtarCellView.h"

@interface HCMyInfoViewController () <MMTableViewInfoDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
}

@end

@implementation HCMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    [self setBackBarButton];
    [self setRightBarButtonTitle:@"保存"];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:contentTableView];
    
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(contentTableView.frame), 14);
    tableHeaderView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.tableHeaderView = tableHeaderView;
    
    [self reloadTableView];
}

-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    [self addAvtarImageSection];
}

-(void)addAvtarImageSection
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeAvtarImageCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickAvtarImageCell:)
                                                           actionTarget:self
                                                                 height:80.0
                                                               userInfo:nil];
    
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeAvtarImageCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCMyInfoAvtarCellView *cellView = [HCMyInfoAvtarCellView nibView];
        cell.m_subContentView = cellView;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCMyInfoAvtarCellView *cellView = (HCMyInfoAvtarCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
}

-(void)onClickAvtarImageCell:(MMTableViewCellInfo *)cellInfo
{
    
}

-(void)onClickRightButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

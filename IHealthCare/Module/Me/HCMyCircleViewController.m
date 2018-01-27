//
//  HCMyCircleViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/27.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyCircleViewController.h"
#import "HCNormalGroupTitleCellView.h"

@interface HCMyCircleViewController () <MMTableViewInfoDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
    
    NSMutableArray<NSMutableArray *> *m_tableSources;
}

@end

@implementation HCMyCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的圈子";
    [self setBackBarButton];
    
    [self addTableSources];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:contentTableView];
    
    contentTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10.0f)];
    
    [self reloadTableView];
}

-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    for (int i = 0; i < m_tableSources.count; i++)
    {
        MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
        
        NSMutableArray *sectionItem = m_tableSources[i];
        for (int j = 0; j < sectionItem.count; j++)
        {
            NSMutableDictionary *itemInfo = sectionItem[j];
            
            MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeNormalGroupCell:cellInfo:)
                                                                     makeTarget:self
                                                                      actionSel:@selector(onClickSectionCell:)
                                                                   actionTarget:self
                                                                         height:50.0
                                                                       userInfo:nil];
            [cellInfo addUserInfoValue:itemInfo forKey:@"cellData"];
            
            [sectionInfo addCell:cellInfo];
        }
        
        [m_tableViewInfo addSection:sectionInfo];
    }
}

- (void)makeNormalGroupCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCNormalGroupTitleCellView *cellView = [HCNormalGroupTitleCellView nibView];
        cell.m_subContentView = cellView;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCNormalGroupTitleCellView *cellView = (HCNormalGroupTitleCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    NSMutableDictionary *itemInfo =  [cellInfo getUserInfoValueForKey:@"cellData"];
    NSString *title = itemInfo[@"title"];
    
    [cellView setTitle:title];
}

-(void)onClickSectionCell:(MMTableViewCellInfo *)cellInfo
{
    NSMutableDictionary *itemInfo =  [cellInfo getUserInfoValueForKey:@"cellData"];
    NSString *key = itemInfo[@"key"];
    
    if ([key isEqualToString:@"myCustomer"])
    {
        [self showMyCustomerVC];
    }
    else if ([key isEqualToString:@"myTeam"])
    {
        [self showMyTeamVC];
    }
    else if ([key isEqualToString:@"teamManager"])
    {
        [self showTeamManagerVC];
    }

}

-(void)addTableSources
{
    m_tableSources = [NSMutableArray array];
    
    NSMutableArray *section = [NSMutableArray array];
    
    NSMutableDictionary *myCustomer = [NSMutableDictionary dictionary];
    myCustomer[@"title"] = @"我的客户";
    myCustomer[@"key"] = @"myCustomer";
    
    NSMutableDictionary *myTeam = [NSMutableDictionary dictionary];
    myTeam[@"title"] = @"我的团队";
    myTeam[@"key"] = @"myTeam";
    
    [section addObject:myCustomer];
    [section addObject:myTeam];
    
    NSMutableArray *section_teamManager = [NSMutableArray array];
    
    NSMutableDictionary *teamManager = [NSMutableDictionary dictionary];
    teamManager[@"title"] = @"团队管理";
    teamManager[@"key"] = @"teamManager";
    
    [section_teamManager addObject:teamManager];
    
    [m_tableSources addObject:section];
//    [m_tableSources addObject:section_teamManager];
}

-(void)showMyCustomerVC
{
    NSLog(@"showMyCustomerVC");
}

-(void)showMyTeamVC
{
    NSLog(@"showMyTeamVC");
}

-(void)showTeamManagerVC
{
    NSLog(@"showTeamManagerVC");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

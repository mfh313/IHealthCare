//
//  HCWealthManagementViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCWealthManagementViewController.h"
#import "HCGetHealthControlsApi.h"
#import "HCHealthManagementCellView.h"
#import "HCManagementDetailModel.h"
#import "HCHealthManagementDetailViewController.h"

@interface HCWealthManagementViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCHealthManagementCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray<HCManagementDetailModel *> *m_healthControls;
    
    NSInteger m_currentPage;
}

@end

@implementation HCWealthManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"财富管理";
    
    m_cellInfos = [NSMutableArray array];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    [self getHealthControls];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getHealthControls];
    }];
    
    [m_tableView addInfiniteScrollingWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getHealthControlsMore];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [self getHealthControls];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_cellInfos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    if ([identifier isEqualToString:@"healthControls"])
    {
        return [self tableView:tableView healthControlsCellForIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    cell.textLabel.text = identifier;
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView healthControlsCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCHealthManagementCellView *cellView = [HCHealthManagementCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCManagementDetailModel *itemModel = m_healthControls[attachIndex];
    
    HCHealthManagementCellView *cellView = (HCHealthManagementCellView *)cell.m_subContentView;
    [cellView setManagementDetail:itemModel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(void)getHealthControls
{
    m_currentPage = 1;
    
    __weak typeof(self) weakSelf = self;
    HCGetHealthControlsApi *mfApi = [HCGetHealthControlsApi new];
    mfApi.type = CONTROL_WEALTH;
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *healthControlArray = [NSMutableArray array];
        NSArray *healthControls = mfApi.responseNetworkData;
        for (int i = 0; i < healthControls.count; i++) {
            HCManagementDetailModel *itemModel = [HCManagementDetailModel yy_modelWithDictionary:healthControls[i]];
            [healthControlArray addObject:itemModel];
        }
        m_healthControls = healthControlArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)getHealthControlsMore
{
    m_currentPage++;
    
    __weak typeof(self) weakSelf = self;
    HCGetHealthControlsApi *mfApi = [HCGetHealthControlsApi new];
    mfApi.type = CONTROL_WEALTH;
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.infiniteScrollingView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            m_currentPage--;
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSMutableArray *healthControlArray = [NSMutableArray array];
        NSArray *healthControls = mfApi.responseNetworkData;
        for (int i = 0; i < healthControls.count; i++) {
            HCManagementDetailModel *itemModel = [HCManagementDetailModel yy_modelWithDictionary:healthControls[i]];
            [healthControlArray addObject:itemModel];
        }
        [m_healthControls addObjectsFromArray:healthControlArray];
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        m_currentPage--;
        [m_tableView.infiniteScrollingView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_healthControls.count; i++) {
        HCManagementDetailModel *itemModel  = m_healthControls[i];
        
        MFTableViewCellObject *healthControl = [MFTableViewCellObject new];
        healthControl.cellHeight = 202.0f;
        healthControl.cellReuseIdentifier = @"healthControls";
        healthControl.attachIndex = i;
        [m_cellInfos addObject:healthControl];
    }
}

#pragma mark - HCHealthManagementCellViewDelegate
-(void)onClickShowManagementDetail:(HCManagementDetailModel *)itemModel
{
    HCHealthManagementDetailViewController *detailVC = [HCHealthManagementDetailViewController new];
    detailVC.hcid = itemModel.hcid;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

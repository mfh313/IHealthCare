//
//  HCHealthManagementViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/3.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHealthManagementViewController.h"
#import "HCGetHealthControlsApi.h"
#import "HCHealthManagementCellView.h"
#import "HCManagementDetailModel.h"
#import "HCHealthManagementDetailViewController.h"
#import "HCGetHealthControlBannersApi.h"
#import "HCScrollBannerCellView.h"

@interface HCHealthManagementViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCHealthManagementCellViewDelegate,HCScrollBannerCellViewDataSource,HCScrollBannerCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray<HCManagementDetailModel *> *m_healthControls;
    
    NSMutableArray *m_bannerData;
    
    NSInteger m_currentPage;
}

@end

@implementation HCHealthManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    else if ([identifier isEqualToString:@"banner"])
    {
        return [self tableView:tableView bannerCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView bannerCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCScrollBannerCellView *cellView = [[HCScrollBannerCellView alloc] initWithFrame:cell.contentView.frame];
        cellView.m_dataSource = self;
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    HCScrollBannerCellView *cellView = (HCScrollBannerCellView *)cell.m_subContentView;
    [cellView reloadBanner];
    
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
    mfApi.type = CONTROL_HEALTH;
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
    
    [self getBannerData];
}

-(void)getHealthControlsMore
{
    m_currentPage++;
    
    __weak typeof(self) weakSelf = self;
    HCGetHealthControlsApi *mfApi = [HCGetHealthControlsApi new];
    mfApi.type = CONTROL_HEALTH;
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

-(void)getBannerData
{
    __weak typeof(self) weakSelf = self;
    HCGetHealthControlBannersApi *mfApi = [HCGetHealthControlBannersApi new];
    mfApi.csid = CONTROL_HEALTH;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *responseNetworkData = mfApi.responseNetworkData;
        NSMutableArray *data = [NSMutableArray array];
        for (int i = 0; i < responseNetworkData.count; i++) {
            HCManagementDetailModel *itemModel = [HCManagementDetailModel yy_modelWithDictionary:responseNetworkData[i]];
            [data addObject:itemModel];
        }
        
        m_bannerData = data;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
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
    
    MFTableViewCellObject *banner = [MFTableViewCellObject new];
    banner.cellHeight = [self imageHeight];
    banner.cellReuseIdentifier = @"banner";
    [m_cellInfos addObject:banner];
    
    for (int i = 0; i < m_healthControls.count; i++) {
        HCManagementDetailModel *itemModel  = m_healthControls[i];
        
        MFTableViewCellObject *healthControl = [MFTableViewCellObject new];
        healthControl.cellHeight = [self imageHeight] + 38;
        healthControl.cellReuseIdentifier = @"healthControls";
        healthControl.attachIndex = i;
        [m_cellInfos addObject:healthControl];
    }
}

-(CGFloat)imageHeight
{
    CGFloat widthPix = CGRectGetWidth(self.view.frame) - 20;
    CGFloat imageHeight = widthPix * 519.0 / 980.0;
    return imageHeight;
}

#pragma mark - HCHealthManagementCellViewDelegate
-(void)onClickShowManagementDetail:(HCManagementDetailModel *)itemModel
{
    HCHealthManagementDetailViewController *detailVC = [HCHealthManagementDetailViewController new];
    detailVC.hcid = itemModel.hcid;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - HCScrollBannerCellViewDataSource
-(NSArray *)imagesURLStringsScrollView:(HCScrollBannerCellView *)cycleScrollView
{
    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    for (int i = 0; i < m_bannerData.count; i++) {
        HCManagementDetailModel *itemModel = m_bannerData[i];
        [imagesURLStrings safeAddObject:itemModel.imageUrl];
    }
    
    return imagesURLStrings;
}

#pragma mark - HCScrollBannerCellViewDelegate
-(void)onClickScrollView:(HCScrollBannerCellView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    HCManagementDetailModel *itemModel = m_bannerData[index];
    [self onClickShowManagementDetail:itemModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

//
//  HCBestNewsMainViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/16.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCBestNewsMainViewController.h"
#import "HCBestNewsDetailModel.h"
#import "HCGetBestNewsApi.h"
#import "HCBestNewsCellView.h"
#import "HCBestNewsDetailViewController.h"
#import "HCScrollBannerCellView.h"
#import "HCGetBestNewsBannersApi.h"

@interface HCBestNewsMainViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCBestNewsCellViewDelegate,HCScrollBannerCellViewDataSource,HCScrollBannerCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray *m_bestNews;
    
    NSMutableArray *m_bestNewsBanner;
    
    NSInteger m_currentPage;
}

@end

@implementation HCBestNewsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    m_cellInfos = [NSMutableArray array];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    [self getBestNews];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getBestNews];
    }];
    
    [m_tableView addInfiniteScrollingWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getBestNewsMore];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getBestNews];
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
    if ([identifier isEqualToString:@"bestNews"])
    {
        return [self tableView:tableView bestNewsCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView bestNewsCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCBestNewsCellView *cellView = [HCBestNewsCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCBestNewsDetailModel *itemModel = m_bestNews[attachIndex];

    HCBestNewsCellView *cellView = (HCBestNewsCellView *)cell.m_subContentView;
    [cellView setNewsDetail:itemModel];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(void)getBestNews
{
    m_currentPage = 1;
    
    __weak typeof(self) weakSelf = self;
    HCGetBestNewsApi *mfApi = [HCGetBestNewsApi new];
    mfApi.type = BestNews_Type_Default;
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *bestNews = mfApi.responseNetworkData;
        NSMutableArray *news = [NSMutableArray array];
        for (int i = 0; i < bestNews.count; i++) {
            HCBestNewsDetailModel *itemModel = [HCBestNewsDetailModel yy_modelWithDictionary:bestNews[i]];
            [news addObject:itemModel];
        }
        m_bestNews = news;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
    
    [self getBannerData];
}

-(void)getBestNewsMore
{
    m_currentPage++;
    
    __weak typeof(self) weakSelf = self;
    HCGetBestNewsApi *mfApi = [HCGetBestNewsApi new];
    mfApi.type = BestNews_Type_Default;
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.infiniteScrollingView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            m_currentPage--;
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *bestNews = mfApi.responseNetworkData;
        NSMutableArray *news = [NSMutableArray array];
        for (int i = 0; i < bestNews.count; i++) {
            HCBestNewsDetailModel *itemModel = [HCBestNewsDetailModel yy_modelWithDictionary:bestNews[i]];
            [news addObject:itemModel];
        }
        
        [m_bestNews addObjectsFromArray:news];
        
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
    HCGetBestNewsBannersApi *mfApi = [HCGetBestNewsBannersApi new];
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *bestNews = mfApi.responseNetworkData;
        NSMutableArray *news = [NSMutableArray array];
        for (int i = 0; i < bestNews.count; i++) {
            HCBestNewsDetailModel *itemModel = [HCBestNewsDetailModel yy_modelWithDictionary:bestNews[i]];
            [news addObject:itemModel];
        }
        m_bestNewsBanner = news;
        
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
    banner.cellHeight = 202.0f;
    banner.cellReuseIdentifier = @"banner";
    [m_cellInfos addObject:banner];
    
    for (int i = 0; i < m_bestNews.count; i++) {
        HCBestNewsDetailModel *itemModel  = m_bestNews[i];
        
        MFTableViewCellObject *highProducts = [MFTableViewCellObject new];
        highProducts.cellHeight = 202.0f;
        highProducts.cellReuseIdentifier = @"bestNews";
        highProducts.attachIndex = i;
        [m_cellInfos addObject:highProducts];
    }
}

#pragma mark - HCBestNewsCellViewDelegate
-(void)onClickShowNewsDetail:(HCBestNewsDetailModel *)itemModel
{
    HCBestNewsDetailViewController *detailVC = [HCBestNewsDetailViewController new];
    detailVC.bid = itemModel.bid;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - HCScrollBannerCellViewDataSource
-(NSArray *)imagesURLStringsScrollView:(HCScrollBannerCellView *)cycleScrollView
{
    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    for (int i = 0; i < m_bestNewsBanner.count; i++) {
        HCBestNewsDetailModel *itemModel = m_bestNewsBanner[i];
        [imagesURLStrings safeAddObject:itemModel.imageUrl];
    }
    
    return imagesURLStrings;
}

#pragma mark - HCScrollBannerCellViewDelegate
-(void)onClickScrollView:(HCScrollBannerCellView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    HCBestNewsDetailModel *itemModel = m_bestNewsBanner[index];
    [self onClickShowNewsDetail:itemModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

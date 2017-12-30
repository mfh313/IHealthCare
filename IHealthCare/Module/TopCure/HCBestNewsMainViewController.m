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

@interface HCBestNewsMainViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCBestNewsCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray *m_bestNews;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    cell.textLabel.text = identifier;
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
    __weak typeof(self) weakSelf = self;
    HCGetBestNewsApi *mfApi = [HCGetBestNewsApi new];
    mfApi.type = BestNews_Type_Default;
    mfApi.page = 0;
    
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
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_bestNews.count; i++) {
        HCBestNewsDetailModel *itemModel  = m_bestNews[i];
        
        MFTableViewCellObject *highProducts = [MFTableViewCellObject new];
        highProducts.cellHeight = 230.0f;
        highProducts.cellReuseIdentifier = @"bestNews";
        highProducts.attachIndex = i;
        [m_cellInfos addObject:highProducts];
    }
}

#pragma mark - HCBestNewsCellViewDelegate
-(void)onClickShowNewsDetail:(HCBestNewsDetailModel *)itemModel
{
    HCBestNewsDetailViewController *detailVC = [HCBestNewsDetailViewController new];
    detailVC.detailModel = itemModel;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

//
//  HCHighProductMainViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/16.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHighProductMainViewController.h"
#import "HCGetProductsApi.h"
#import "HCProductDetailModel.h"
#import "HCHighProductCellView.h"
#import "HCHighProductDetailViewController.h"

@interface HCHighProductMainViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCHighProductCellViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray *m_highProducts;
    
    NSInteger m_currentPage;
}

@end

@implementation HCHighProductMainViewController

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
    
    [self getHighProducts];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getHighProducts];
    }];
    
    [m_tableView addInfiniteScrollingWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getHighProductsMore];
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
    if ([identifier isEqualToString:@"highProducts"])
    {
        return [self tableView:tableView highProductsCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView highProductsCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCHighProductCellView *cellView = [HCHighProductCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    HCProductDetailModel *itemModel = m_highProducts[attachIndex];

    HCHighProductCellView *cellView = (HCHighProductCellView *)cell.m_subContentView;
    [cellView setProductDetail:itemModel];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(void)getHighProducts
{
    m_currentPage = 1;
    
    __weak typeof(self) weakSelf = self;
    HCGetProductsApi *mfApi = [HCGetProductsApi new];
    mfApi.cid = PRODUCT_HIGHT_SERVICE;
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *highProducts = mfApi.responseNetworkData;
        NSMutableArray *products = [NSMutableArray array];
        for (int i = 0; i < highProducts.count; i++) {
            HCProductDetailModel *itemModel = [HCProductDetailModel yy_modelWithDictionary:highProducts[i]];
            [products addObject:itemModel];
        }
        m_highProducts = products;

        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)getHighProductsMore
{
    m_currentPage++;
    
    __weak typeof(self) weakSelf = self;
    HCGetProductsApi *mfApi = [HCGetProductsApi new];
    mfApi.cid = PRODUCT_HIGHT_SERVICE;
    mfApi.page = m_currentPage;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.infiniteScrollingView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            m_currentPage--;
            return;
        }
        
        NSArray *highProducts = mfApi.responseNetworkData;
        NSMutableArray *products = [NSMutableArray array];
        for (int i = 0; i < highProducts.count; i++) {
            HCProductDetailModel *itemModel = [HCProductDetailModel yy_modelWithDictionary:highProducts[i]];
            [products addObject:itemModel];
        }
        [m_highProducts addObjectsFromArray:products];
        
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
    
    for (int i = 0; i < m_highProducts.count; i++) {
        HCProductDetailModel *itemModel  = m_highProducts[i];
        
        MFTableViewCellObject *highProducts = [MFTableViewCellObject new];
        highProducts.cellHeight = 202.0f;
        highProducts.cellReuseIdentifier = @"highProducts";
        highProducts.attachIndex = i;
        [m_cellInfos addObject:highProducts];
    }
}

#pragma mark - HCHighProductCellViewDelegate
-(void)onClickShowProductDetail:(HCProductDetailModel *)itemModel
{
    HCHighProductDetailViewController *detailVC = [HCHighProductDetailViewController new];
    detailVC.pid = itemModel.pid;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

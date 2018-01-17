//
//  HCHighProductDetailViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/21.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCHighProductDetailViewController.h"
#import "HCProductDetailModel.h"
#import "HCHighProductDetailCustomNavbar.h"
#import "HCHighProductDetailBottomView.h"
#import "HCProductDetailHeaderTitleView.h"
#import "HCCreateOrderViewController.h"
#import "HCGetProductDetailApi.h"

@interface HCHighProductDetailViewController () <HCHighProductDetailCustomNavbarDelegate,HCHighProductDetailBottomViewDelegate,tableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    HCHighProductDetailCustomNavbar *m_navBar;
    HCHighProductDetailBottomView *m_bottomView;
    
    MFUITableView *m_tableView;
}

@property (nonatomic,strong) HCProductDetailModel *detailModel;

@end

@implementation HCHighProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    m_navBar = [HCHighProductDetailCustomNavbar nibView];
    m_navBar.m_delegate = self;
    [self.view addSubview:m_navBar];
    [m_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(44));
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view);
    }];
    
    m_bottomView = [HCHighProductDetailBottomView nibView];
    m_bottomView.m_delegate = self;
    [self.view addSubview:m_bottomView];
    [m_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(60));
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
    }];
    
    [self getProductDetail];
}

-(void)getProductDetail
{
    __weak typeof(self) weakSelf = self;
    HCGetProductDetailApi *mfApi = [HCGetProductDetailApi new];
    mfApi.pid = self.pid;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *product = mfApi.responseNetworkData;
        HCProductDetailModel *itemModel = [HCProductDetailModel yy_modelWithDictionary:product];
        strongSelf.detailModel = itemModel;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    
    if ([identifier isEqualToString:@"productImage"])
    {
        return [self tableView:tableView productImageCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"productTitle"])
    {
        return [self tableView:tableView productTitleCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"productDetail"])
    {
        return [self tableView:tableView productDetailCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView productImageCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIImageView *cellView = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
//        cellView.contentMode = UIViewContentModeScaleAspectFill;
        cell.m_subContentView = cellView;
    }
    
    UIImageView *cellView = (UIImageView *)cell.m_subContentView;
    [cellView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.image]];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView productTitleCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCProductDetailHeaderTitleView *cellView = [HCProductDetailHeaderTitleView nibView];
        cellView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
        cell.m_subContentView = cellView;
    }
    
    HCProductDetailHeaderTitleView *cellView = (HCProductDetailHeaderTitleView *)cell.m_subContentView;
    [cellView setProductDetail:self.detailModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView productDetailCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
        
        UITextView *cellView = [[UITextView alloc] initWithFrame:cell.contentView.frame];
        cellView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
        cellView.font = [UIFont systemFontOfSize:16.0f];
        cellView.textColor = [UIColor hx_colorWithHexString:@"333333"];
        cellView.userInteractionEnabled = NO;
        cell.m_subContentView = cellView;
    }
    
    UITextView *cellView = (UITextView *)cell.m_subContentView;
    cellView.frame = CGRectMake(20, 0, CGRectGetWidth(cell.contentView.frame) - 45, CGRectGetHeight(cell.contentView.frame) - 0);
    [cellView setText:self.detailModel.detail];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

#pragma mark - HCHighProductDetailCustomNavbarDelegate
-(void)onClickBackButton:(HCHighProductDetailCustomNavbar *)navBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onClickForwordButton:(HCHighProductDetailCustomNavbar *)navBar
{
    NSLog(@"onClickForwordButton");
}

#pragma mark - HCHighProductDetailBottomViewDelegate
-(void)onClickBuyProduct
{
    [self showCreateOrderVC];
}

-(void)onClickCollectionProduct
{
    NSLog(@"onClickCollectionProduct");
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    MFTableViewCellObject *productImage = [MFTableViewCellObject new];
    productImage.cellHeight = 200.0f;
    productImage.cellReuseIdentifier = @"productImage";
    [m_cellInfos addObject:productImage];
    
    MFTableViewCellObject *productTitle = [MFTableViewCellObject new];
    productTitle.cellHeight = 80.0f;
    productTitle.cellReuseIdentifier = @"productTitle";
    [m_cellInfos addObject:productTitle];
    
    MFTableViewCellObject *productDetail = [MFTableViewCellObject new];
    productDetail.cellHeight = [self textHeightForNewsDetail:self.detailModel.detail];
    productDetail.cellReuseIdentifier = @"productDetail";
    [m_cellInfos addObject:productDetail];
}

-(CGFloat)textHeightForNewsDetail:(NSString *)detail
{
    return [detail MMSizeWithFont:[UIFont systemFontOfSize:16.0f] maxSize:CGSizeMake(CGRectGetWidth(self.view.frame) - 45, CGFLOAT_MAX)].height + 30;
}

-(void)reloadTableView
{
    [self makeCellObjects];
    
    [m_tableView reloadData];
}

-(void)showCreateOrderVC
{
    HCCreateOrderViewController *createOrderVC = [HCCreateOrderViewController new];
    createOrderVC.detailModel = self.detailModel;
    [self.navigationController pushViewController:createOrderVC animated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

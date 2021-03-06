//
//  HCHealthManagementDetailViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/1.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCHealthManagementDetailViewController.h"
#import "HCManagementDetailModel.h"
#import "HCHighProductDetailCustomNavbar.h"
#import "HCHealthManageDetailHeaderTitleView.h"
#import "HCGetHealthControlDetailApi.h"
#import "HCHighProductDetailBottomView.h"
#import "HCAddFavoritesApi.h"
#import "HCHealthManageCreateOrderViewController.h"

@interface HCHealthManagementDetailViewController () <HCHighProductDetailCustomNavbarDelegate,tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCHealthManageDetailHeaderTitleViewDelegate,HCHighProductDetailBottomViewDelegate>
{
    HCHighProductDetailCustomNavbar *m_navBar;
    HCHighProductDetailBottomView *m_bottomView;
    
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
}

@property (nonatomic,strong) HCManagementDetailModel *detailModel;

@end

@implementation HCHealthManagementDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_cellInfos = [NSMutableArray array];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 20) style:UITableViewStylePlain];
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
    
    [self getHealthControlDetail];
}

-(void)getHealthControlDetail
{
    __weak typeof(self) weakSelf = self;
    HCGetHealthControlDetailApi *mfApi = [HCGetHealthControlDetailApi new];
    mfApi.hcid = self.hcid;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *product = mfApi.responseNetworkData;
        HCManagementDetailModel *itemModel = [HCManagementDetailModel yy_modelWithDictionary:product];
        strongSelf.detailModel = itemModel;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
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
    
    if ([identifier isEqualToString:@"healthImage"])
    {
        return [self tableView:tableView healthImageCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"healthTitle"])
    {
        return [self tableView:tableView healthTitleCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"healthDetail"])
    {
        return [self tableView:tableView healthDetailCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView healthImageCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIImageView *cellView = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
        cellView.contentMode = UIViewContentModeScaleAspectFill;
        cell.m_subContentView = cellView;
    }
    
    UIImageView *cellView = (UIImageView *)cell.m_subContentView;
    [cellView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.imageUrl]];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView healthTitleCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCHealthManageDetailHeaderTitleView *cellView = [HCHealthManageDetailHeaderTitleView nibView];
        cellView.m_delegate = self;
        cellView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
        cell.m_subContentView = cellView;
    }
    
    HCHealthManageDetailHeaderTitleView *cellView = (HCHealthManageDetailHeaderTitleView *)cell.m_subContentView;
    [cellView setManagementDetail:self.detailModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView healthDetailCellForIndexPath:(NSIndexPath *)indexPath
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
    HCHealthManageCreateOrderViewController *createOrderVC = [HCHealthManageCreateOrderViewController new];
    createOrderVC.detailModel = self.detailModel;
    [self.navigationController pushViewController:createOrderVC animated:YES];
}

-(void)onClickCollectionProduct
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCAddFavoritesApi *mfApi = [HCAddFavoritesApi new];
    mfApi.favoriteId = self.detailModel.hcid;
    mfApi.userTel = loginService.userPhone;
    mfApi.category = self.detailModel.cid;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:@"收藏成功"];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    MFTableViewCellObject *HealthImage = [MFTableViewCellObject new];
    HealthImage.cellHeight = [self imageHeight];
    HealthImage.cellReuseIdentifier = @"healthImage";
    [m_cellInfos addObject:HealthImage];
    
    MFTableViewCellObject *healthTitle = [MFTableViewCellObject new];
    healthTitle.cellHeight = 80.0f;
    healthTitle.cellReuseIdentifier = @"healthTitle";
    [m_cellInfos addObject:healthTitle];
    
    MFTableViewCellObject *healthDetail = [MFTableViewCellObject new];
    healthDetail.cellHeight = [self textHeightForNewsDetail:self.detailModel.detail];
    healthDetail.cellReuseIdentifier = @"healthDetail";
    [m_cellInfos addObject:healthDetail];
}

-(CGFloat)imageHeight
{
    CGFloat widthPix = CGRectGetWidth(self.view.frame);
    CGFloat imageHeight = widthPix * 519.0 / 980.0;
    return imageHeight;
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

#pragma mark - HCHealthManageDetailHeaderTitleViewDelegate
-(void)onClickChat:(HCManagementDetailModel *)itemModel
{
    NSLog(@"onClickChat");
}

-(void)onClickFollowUp:(HCManagementDetailModel *)itemModel;
{
    NSLog(@"onClickFollowUp");
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

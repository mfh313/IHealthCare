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
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "HCCreateOrderApi.h"
#import "HCLoginService.h"
#import "HCPayOrderApi.h"

@interface HCHighProductDetailViewController () <HCHighProductDetailCustomNavbarDelegate,HCHighProductDetailBottomViewDelegate,tableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    HCHighProductDetailCustomNavbar *m_navBar;
    HCHighProductDetailBottomView *m_bottomView;
    
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSInteger m_oid;
}

@end

@implementation HCHighProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_cellInfos = [NSMutableArray array];
    
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
    
    [self reloadTableView];
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
        cellView.contentMode = UIViewContentModeScaleToFill;
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
    [cellView setText:self.detailModel.pdesc];
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
    [self createOrder];
}

-(void)onClickCollectionProduct
{
    [self payOrder];
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
    productDetail.cellHeight = 300.0f;
    productDetail.cellReuseIdentifier = @"productDetail";
    [m_cellInfos addObject:productDetail];
}

-(void)reloadTableView
{
    [self makeCellObjects];
    
    [m_tableView reloadData];
}

-(void)createOrder
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    NSMutableArray *carts = [NSMutableArray array];
    
    HCOrderItemModel *testItem = [HCOrderItemModel new];
    testItem.pid = self.detailModel.pid;
    testItem.count = 1;
    
    [carts addObject:testItem];
    
    __weak typeof(self) weakSelf = self;
    HCCreateOrderApi *mfApi = [HCCreateOrderApi new];
    mfApi.userTel = loginService.userPhone;
    mfApi.authCode = loginService.token;
    mfApi.name = @"马方华";
    mfApi.phone = @"15811809295";
    mfApi.addr = @"广东省深圳市福田区下沙四坊23号";
    mfApi.carts = carts;
    
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *createOrderInfo = mfApi.responseNetworkData;
        NSNumber *oid = createOrderInfo[@"oid"];
        m_oid = oid.intValue;
        
        [strongSelf showTips:@"创建订单成功，点击收藏按钮付款"];
        
//        NSMutableArray *news = [NSMutableArray array];
//        for (int i = 0; i < bestNews.count; i++) {
//            HCBestNewsDetailModel *itemModel = [HCBestNewsDetailModel yy_modelWithDictionary:bestNews[i]];
//            [news addObject:itemModel];
//        }
//        m_bestNews = news;
//
//        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)payOrder
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCPayOrderApi *mfApi = [HCPayOrderApi new];
    mfApi.userTel = loginService.userPhone;
    mfApi.authCode = loginService.token;
    mfApi.oid = m_oid;
    
    mfApi.animatingText = @"正在支付";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *payInfo = mfApi.responseNetworkData;
        NSLog(@"payInfo=%@",payInfo);
        
        [strongSelf bizPayOrder:payInfo];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)bizPay {
    NSString *res = [WXApiRequestHandler jumpToBizPay];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
    }
}

-(void)bizPayOrder:(NSDictionary *)dict
{
    NSMutableString *stamp  = [dict objectForKey:@"timeStamp"];
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayId"];
    req.nonceStr            = [dict objectForKey:@"nonceStr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [dict objectForKey:@"packAge"];
    req.sign                = [dict objectForKey:@"paySign"];
    [WXApi sendReq:req];
    
//    NSLog(@"appid=%@\npartnerId=%@\nprepayId=%@\nnonceStr=%@\ntimeStamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appId"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

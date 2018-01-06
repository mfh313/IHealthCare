//
//  HCBestNewsDetailViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/30.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCBestNewsDetailViewController.h"
#import "HCBestNewsDetailModel.h"
#import "HCHighProductDetailCustomNavbar.h"
#import "HCBestNewsDetailTitleView.h"
#import "HCBestNewsDetailToolBar.h"

@interface HCBestNewsDetailViewController () <HCHighProductDetailCustomNavbarDelegate,tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCBestNewsDetailToolBarDelegate>
{
    HCHighProductDetailCustomNavbar *m_navBar;
    HCBestNewsDetailToolBar *m_toolBar;
    
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
}

@end

@implementation HCBestNewsDetailViewController

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
    m_tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
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
    
    m_toolBar = [HCBestNewsDetailToolBar nibView];
    m_toolBar.m_delegate = self;
    [self.view addSubview:m_toolBar];
    [m_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(60));
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
    }];
    
    [self reloadTableView];
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
    
    if ([identifier isEqualToString:@"newsImage"])
    {
        return [self tableView:tableView newsImageCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"newsTitle"])
    {
        return [self tableView:tableView newsTitleCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"newsDetail"])
    {
        return [self tableView:tableView newsDetailCellForIndexPath:indexPath];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView newsImageCellForIndexPath:(NSIndexPath *)indexPath
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
    [cellView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.imageUrl]];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView newsTitleCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCBestNewsDetailTitleView *cellView = [HCBestNewsDetailTitleView nibView];
        cellView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
        cell.m_subContentView = cellView;
    }
    
    HCBestNewsDetailTitleView *cellView = (HCBestNewsDetailTitleView *)cell.m_subContentView;
    [cellView setNewsDetail:self.detailModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView newsDetailCellForIndexPath:(NSIndexPath *)indexPath
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
    [cellView setText:self.detailModel.newsDescription];
    return cell;
}

-(void)reloadTableView
{
    [self makeCellObjects];
    
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    MFTableViewCellObject *newsImage = [MFTableViewCellObject new];
    newsImage.cellHeight = 200.0f;
    newsImage.cellReuseIdentifier = @"newsImage";
    [m_cellInfos addObject:newsImage];
    
    MFTableViewCellObject *newsTitle = [MFTableViewCellObject new];
    newsTitle.cellHeight = 80.0f;
    newsTitle.cellReuseIdentifier = @"newsTitle";
    [m_cellInfos addObject:newsTitle];
    
    MFTableViewCellObject *newsDetail = [MFTableViewCellObject new];
    newsDetail.cellHeight = 300.0f;
    newsDetail.cellReuseIdentifier = @"newsDetail";
    [m_cellInfos addObject:newsDetail];
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

#pragma mark - HCBestNewsDetailToolBarDelegate
-(void)onClickMessageButton:(HCBestNewsDetailToolBar *)toolBar
{
    NSLog(@"onClickMessageButton");
}

-(void)onClickPraiseButton:(HCBestNewsDetailToolBar *)toolBar
{
    NSLog(@"onClickPraiseButton");
}

-(void)onClickCollectionButton:(HCBestNewsDetailToolBar *)toolBar
{
    NSLog(@"onClickCollectionButton");
}

-(void)onClickWriteButton:(HCBestNewsDetailToolBar *)toolBar
{
    NSLog(@"onClickWriteButton");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
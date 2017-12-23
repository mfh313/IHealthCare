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

@interface HCHighProductDetailViewController () <HCHighProductDetailCustomNavbarDelegate,HCHighProductDetailBottomViewDelegate,tableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    HCHighProductDetailCustomNavbar *m_navBar;
    HCHighProductDetailBottomView *m_bottomView;
    
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
}

@end

@implementation HCHighProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_cellInfos = [NSMutableArray array];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
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
        make.centerX.equalTo(self.view);
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
//        return [self tableView:tableView highProductsCellForIndexPath:indexPath];
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

#pragma mark - HCHighProductDetailCustomNavbarDelegate
-(void)onClickBackButton:(HCHighProductDetailCustomNavbar *)navBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onClickForwordButton:(HCHighProductDetailCustomNavbar *)navBar
{
    
}

#pragma mark - HCHighProductDetailBottomViewDelegate
-(void)onClickBuyProduct
{
    NSLog(@"onClickBuyProduct");
}

-(void)onClickCollectionProduct
{
    NSLog(@"onClickCollectionProduct");
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    MFTableViewCellObject *productImage = [MFTableViewCellObject new];
    productImage.cellHeight = 200.0f;
    productImage.cellReuseIdentifier = @"productImage";
    [m_cellInfos addObject:productImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

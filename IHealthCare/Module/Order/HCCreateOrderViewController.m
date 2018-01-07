//
//  HCCreateOrderViewController.m
//  IHealthCare
//
//  Created by 马方华 on 2018/1/7.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCCreateOrderViewController.h"
#import "HCProductDetailModel.h"
#import "HCCreateOrderApi.h"
#import "HCLoginService.h"
#import "HCPayOrderApi.h"

@interface HCCreateOrderViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
}

@end

@implementation HCCreateOrderViewController

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
    
    [self getMyAddressInfo];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    
//    if ([identifier isEqualToString:@"productImage"])
//    {
//        return [self tableView:tableView productImageCellForIndexPath:indexPath];
//    }
//    else if ([identifier isEqualToString:@"productTitle"])
//    {
//        return [self tableView:tableView productTitleCellForIndexPath:indexPath];
//    }
//    else if ([identifier isEqualToString:@"productDetail"])
//    {
//        return [self tableView:tableView productDetailCellForIndexPath:indexPath];
//    }
    
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

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    [self addAddress];
    
    MFTableViewCellObject *productTitle = [MFTableViewCellObject new];
    productTitle.cellHeight = 80.0f;
    productTitle.cellReuseIdentifier = @"productTitle";
    [m_cellInfos addObject:productTitle];
    
    MFTableViewCellObject *productDetail = [MFTableViewCellObject new];
    productDetail.cellHeight = 300.0f;
    productDetail.cellReuseIdentifier = @"productDetail";
    [m_cellInfos addObject:productDetail];
}

-(void)addAddress
{
    MFTableViewCellObject *address = [MFTableViewCellObject new];
    address.cellHeight = 90.0f;
    address.cellReuseIdentifier = @"address";
    [m_cellInfos addObject:address];
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)getMyAddressInfo
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

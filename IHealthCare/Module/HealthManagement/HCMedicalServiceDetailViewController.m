//
//  HCMedicalServiceDetailViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/10.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMedicalServiceDetailViewController.h"
#import "HCMedicalServiceDetailModel.h"
#import "HCHighProductDetailCustomNavbar.h"
#import "HCMedicalServiceDetailHeaderTitleView.h"

@interface HCMedicalServiceDetailViewController () <HCHighProductDetailCustomNavbarDelegate,tableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    HCHighProductDetailCustomNavbar *m_navBar;
    
    MFUITableView *m_tableView;
}

@end

@implementation HCMedicalServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    if ([identifier isEqualToString:@"headImage"])
    {
        return [self tableView:tableView headImageCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"headTitle"])
    {
        return [self tableView:tableView headTitleCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"detail"])
    {
        return [self tableView:tableView detailCellForIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView headImageCellForIndexPath:(NSIndexPath *)indexPath
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
    [cellView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.imageUrl]];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView headTitleCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCMedicalServiceDetailHeaderTitleView *cellView = [HCMedicalServiceDetailHeaderTitleView nibView];
        cell.m_subContentView = cellView;
    }
    
    HCMedicalServiceDetailHeaderTitleView *cellView = (HCMedicalServiceDetailHeaderTitleView *)cell.m_subContentView;
    [cellView setMedicalService:self.detailModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView detailCellForIndexPath:(NSIndexPath *)indexPath
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

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    MFTableViewCellObject *headImage = [MFTableViewCellObject new];
    headImage.cellHeight = 200.0f;
    headImage.cellReuseIdentifier = @"headImage";
    [m_cellInfos addObject:headImage];
    
    MFTableViewCellObject *headTitle = [MFTableViewCellObject new];
    headTitle.cellHeight = 96.0f;
    headTitle.cellReuseIdentifier = @"headTitle";
    [m_cellInfos addObject:headTitle];
    
    MFTableViewCellObject *detail = [MFTableViewCellObject new];
    detail.cellHeight = [self textHeightForNewsDetail:self.detailModel.detail];
    detail.cellReuseIdentifier = @"detail";
    [m_cellInfos addObject:detail];
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

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

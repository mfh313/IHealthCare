//
//  HCOrderAddressCreateViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressCreateViewController.h"
#import "HCOrderAddressCreateTextCellView.h"
#import "HCOrderAddressCreateRegionCellView.h"
#import "HCOrderAddressCreateDefaultSetCellView.h"

@interface HCOrderAddressCreateViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCOrderAddressCreateCellViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableDictionary *m_addressInfo;
}

@end

@implementation HCOrderAddressCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建收货地址";
    [self setBackBarButton];
    
    m_addressInfo = [NSMutableDictionary dictionary];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    [self reloadTableView];
    
    [self setBottomView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging && scrollView == m_tableView) {
        [self.view endEditing:YES];
    }
}

- (void)touchesBegan_TableView:(NSSet *)arg1 withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    
    if ([identifier isEqualToString:@"addressText"])
    {
        return [self tableView:tableView addressTextCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"citySelect"])
    {
        return [self tableView:tableView citySelectCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"defaultSet"])
    {
        return [self tableView:tableView defaultSetCellForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"separator"])
    {
        return [self tableView:tableView separatorCellForIndex:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView addressTextCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSString *attachKey = cellInfo.attachKey;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCOrderAddressCreateTextCellView *cellView = [[HCOrderAddressCreateTextCellView alloc] initWithFrame:CGRectZero];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    HCOrderAddressCreateTextCellView *cellView = (HCOrderAddressCreateTextCellView *)cell.m_subContentView;
    cellView.leftTitle = [self leftTitleString:cellInfo];
    cellView.attachKey = attachKey;
    
    [cellView layoutContentViews];
    
    NSString *value = m_addressInfo[attachKey];
    [cellView setTextFieldValue:value];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView citySelectCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSString *attachKey = cellInfo.attachKey;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCOrderAddressCreateRegionCellView *cellView = [[HCOrderAddressCreateRegionCellView alloc] initWithFrame:CGRectZero];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    HCOrderAddressCreateRegionCellView *cellView = (HCOrderAddressCreateRegionCellView *)cell.m_subContentView;
    cellView.leftTitle = [self leftTitleString:cellInfo];
    cellView.attachKey = attachKey;
    
    [cellView layoutContentViews];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView defaultSetCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSString *attachKey = cellInfo.attachKey;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCOrderAddressCreateDefaultSetCellView *cellView = [[HCOrderAddressCreateDefaultSetCellView alloc] initWithFrame:CGRectZero];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    HCOrderAddressCreateDefaultSetCellView *cellView = (HCOrderAddressCreateDefaultSetCellView *)cell.m_subContentView;
    cellView.leftTitle = [self leftTitleString:cellInfo];
    cellView.attachKey = attachKey;
    
    [cellView layoutContentViews];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView separatorCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIView *separator = [UIView new];
        separator.frame = CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame), MFOnePixHeight);
        separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        separator.backgroundColor = MFCustomLineColor;
        [cell.contentView addSubview:separator];
    }
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
    
    MFTableViewCellObject *addressText = [MFTableViewCellObject new];
    addressText.cellReuseIdentifier = @"addressText";
    addressText.attachKey = @"name";
    addressText.cellHeight = 70.0f;
    [m_cellInfos addObject:addressText];
    
    [m_cellInfos addObject:[self separatorCellObject]];
    
    MFTableViewCellObject *phone = [MFTableViewCellObject new];
    phone.cellReuseIdentifier = @"addressText";
    phone.attachKey = @"phone";
    phone.cellHeight = 70.0f;
    [m_cellInfos addObject:phone];
    
    [m_cellInfos addObject:[self separatorCellObject]];
    
    MFTableViewCellObject *city = [MFTableViewCellObject new];
    city.cellReuseIdentifier = @"citySelect";
    city.attachKey = @"city";
    city.cellHeight = 70.0f;
    [m_cellInfos addObject:city];
    
    [m_cellInfos addObject:[self separatorCellObject]];
    
    MFTableViewCellObject *addr = [MFTableViewCellObject new];
    addr.cellReuseIdentifier = @"addressText";
    addr.attachKey = @"addr";
    addr.cellHeight = 70.0f;
    [m_cellInfos addObject:addr];
    
    [m_cellInfos addObject:[self separatorCellObject]];
    
    MFTableViewCellObject *defaultSet = [MFTableViewCellObject new];
    defaultSet.cellReuseIdentifier = @"defaultSet";
    defaultSet.attachKey = @"defaultSet";
    defaultSet.cellHeight = 70.0f;
    [m_cellInfos addObject:defaultSet];
}

-(MFTableViewCellObject *)separatorCellObject
{
    MFTableViewCellObject *separator = [MFTableViewCellObject new];
    separator.cellHeight = MFOnePixHeight;
    separator.cellReuseIdentifier = @"separator";
    return separator;
}

-(void)setBottomView
{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@(60));
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
    }];
    
    UIView *separator = [UIView new];
    separator.backgroundColor = MFCustomLineColor;
    [bottomView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom);
        make.width.equalTo(bottomView.mas_width);
        make.height.mas_equalTo(MFOnePixHeight);
    }];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomButton setTitle:@"保存并使用" forState:UIControlStateNormal];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [bottomButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [bottomButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [bottomButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    [bottomButton addTarget:self action:@selector(onClickBottomButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - HCOrderAddressCreateCellViewDelegate
-(BOOL)orderAddressCreateCellView:(HCOrderAddressCreateCellView *)cellView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *contentTextField = [cellView contentTextField];
    
    NSString *content = contentTextField.text;
    
    if ([string isEqualToString:@"\n"]) {
        [contentTextField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)orderAddressTextFiledEditChanged:(HCOrderAddressCreateCellView *)cellView
{
    UITextField *contentTextField = [cellView contentTextField];
    NSString *content = contentTextField.text;
    
    NSString *attachKey = cellView.attachKey;
    
    [m_addressInfo safeSetObject:content forKey:attachKey];
}

-(NSString *)leftTitleString:(MFTableViewCellObject *)cellInfo
{
    NSString *attachKey = cellInfo.attachKey;
    NSString *leftTitle = nil;
    
    if ([attachKey isEqualToString:@"name"]) {
        leftTitle = @"收货人";
    }
    else if ([attachKey isEqualToString:@"phone"])
    {
        leftTitle = @"联系方式";
    }
    else if ([attachKey isEqualToString:@"city"])
    {
        leftTitle = @"所在地区";
    }
    else if ([attachKey isEqualToString:@"addr"])
    {
        leftTitle = @"详细地址";
    }
    else if ([attachKey isEqualToString:@"defaultSet"])
    {
        leftTitle = @"设置为默认地址";
    }
    
    return [leftTitle stringByAppendingString:@":"];
}

-(void)onClickBottomButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

//
//  HCOrderAddressModifyViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/13.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCOrderAddressModifyViewController.h"
#import "HCModifyOrderAddressApi.h"
#import "HCOrderAddressCreateTextCellView.h"
#import "HCOrderAddressCreateRegionCellView.h"
#import "HCOrderAddressCreateDefaultSetCellView.h"

@interface HCOrderAddressModifyViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCOrderAddressCreateCellViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableDictionary *m_addressInfo;
}

@end

@implementation HCOrderAddressModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改收货地址";
    [self setBackBarButton];
    
    m_addressInfo = [self.addressInfo yy_modelToJSONObject];
    
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
    
    NSString *value = m_addressInfo[attachKey];
    
    HCOrderAddressCreateTextCellView *cellView = (HCOrderAddressCreateTextCellView *)cell.m_subContentView;
    cellView.leftTitle = [self leftTitleString:cellInfo];
    cellView.attachKey = attachKey;
    [cellView layoutContentViews];
    [cellView setTextFieldValue:value];
    
    UITextField *contentTextField = [cellView contentTextField];
    if ([attachKey isEqualToString:@"phone"]) {
        contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else
    {
        contentTextField.keyboardType = UIKeyboardTypeDefault;
    }
    
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
    
    NSString *value = m_addressInfo[attachKey];
    
    HCOrderAddressCreateRegionCellView *cellView = (HCOrderAddressCreateRegionCellView *)cell.m_subContentView;
    cellView.leftTitle = [self leftTitleString:cellInfo];
    cellView.attachKey = attachKey;
    
    [cellView layoutContentViews];
    
    [cellView setContentLabelValue:value];
    
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
    [bottomButton setTitle:@"修改地址" forState:UIControlStateNormal];
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

-(void)onClickBottomButton:(id)sender
{
    if ([MFStringUtil isBlankString:m_addressInfo[@"name"]]
        || [MFStringUtil isBlankString:m_addressInfo[@"phone"]]
        || [MFStringUtil isBlankString:m_addressInfo[@"addr"]]
        || [MFStringUtil isBlankString:m_addressInfo[@"city"]])
    {
        [self showTips:@"请输入完整信息"];
        return;
    }
    
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCModifyOrderAddressApi *mfApi = [HCModifyOrderAddressApi new];
    mfApi.aid = self.addressInfo.aid;
    mfApi.userTel = loginService.userPhone;
    mfApi.name = m_addressInfo[@"name"];
    mfApi.phone = m_addressInfo[@"phone"];
    mfApi.addr = m_addressInfo[@"addr"];
    mfApi.city = m_addressInfo[@"city"];
    
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *addressInfo = mfApi.responseNetworkData;
        
        HCOrderUserAddressModel *addressModel = [HCOrderUserAddressModel yy_modelWithDictionary:addressInfo];
        [strongSelf onDidModifyAddressModel:addressModel];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)onDidModifyAddressModel:(HCOrderUserAddressModel *)address
{
    if ([self.m_delegate respondsToSelector:@selector(onModifyAddressInfo:address:)]) {
        [self.m_delegate onModifyAddressInfo:self address:address];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)onClickSelectCity:(HCOrderAddressCreateCellView *)cellView
{
    NSString *attachKey = cellView.attachKey;
    NSArray *cityArray = @[@"深圳市",@"北京市",@"上海市",@"广州市"];
    
    __weak typeof(self) weakSelf = self;
    LGAlertView *alertView = [LGAlertView alertViewWithTitle:nil message:nil style:LGAlertViewStyleActionSheet buttonTitles:cityArray cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSString *value = cityArray[index];
        [m_addressInfo safeSetObject:value forKey:attachKey];
        [strongSelf reloadTableView];
        
    } cancelHandler:^(LGAlertView * _Nonnull alertView) {
        
    } destructiveHandler:nil];
    
    [alertView showAnimated:YES completionHandler:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

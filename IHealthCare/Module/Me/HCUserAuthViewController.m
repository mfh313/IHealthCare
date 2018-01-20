//
//  HCUserAuthViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/19.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserAuthViewController.h"
#import "HCUserAuthApi.h"
#import "HCUserAuthTextInputCellView.h"
#import "HCUserAuthLevelSelectView.h"
#import "HCUserAuthApi.h"
#import "HCMeViewController.h"
#import "HCUserAuthSubmitSuccessViewController.h"

@interface HCUserAuthViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCUserAuthTextInputCellViewDelegate,HCUserAuthLevelSelectViewDelegate,HCUserAuthSubmitSuccessViewControllerDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray *m_authInfos;
    
    NSInteger m_userLevel;
    
    NSMutableDictionary *m_inputInfo;
}

@end

@implementation HCUserAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请身份认证";
    [self setBackBarButton];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor whiteColor];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    m_inputInfo = [NSMutableDictionary dictionary];
    [self initAuthInfos];
    
    [self makeCellObjects];
    
    [m_tableView reloadData];
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

-(void)makeCellObjects
{
    for (int i = 0; i < m_authInfos.count; i++)
    {
        [m_cellInfos addObject:[self blankCellObject:30.0f]];
        
        MFTableViewCellObject *textFieldItem = [MFTableViewCellObject new];
        textFieldItem.cellHeight = 48.0f;
        textFieldItem.cellReuseIdentifier = @"textField";
        textFieldItem.attachIndex = i;
        [m_cellInfos addObject:textFieldItem];
        
        MFTableViewCellObject *separator = [MFTableViewCellObject new];
        separator.cellHeight = MFOnePixHeight;
        separator.cellReuseIdentifier = @"separator";
        separator.attachIndex = i;
        [m_cellInfos addObject:separator];
    }
    
    [m_cellInfos addObject:[self blankCellObject:20.0f]];
    
    MFTableViewCellObject *levelSelect = [MFTableViewCellObject new];
    levelSelect.cellHeight = 40.0f;
    levelSelect.cellReuseIdentifier = @"levelSelect";
    [m_cellInfos addObject:levelSelect];
    
    [m_cellInfos addObject:[self blankCellObject:20.0f]];
    
    MFTableViewCellObject *submitButton = [MFTableViewCellObject new];
    submitButton.cellHeight = 40.0f;
    submitButton.cellReuseIdentifier = @"submitButton";
    [m_cellInfos addObject:submitButton];
    
    [m_cellInfos addObject:[self blankCellObject:20.0f]];
}

-(MFTableViewCellObject *)blankCellObject:(CGFloat)cellHeight
{
    MFTableViewCellObject *blank = [MFTableViewCellObject new];
    blank.cellHeight = cellHeight;
    blank.cellReuseIdentifier = @"blankCell";
    return blank;
}

-(void)initAuthInfos
{
    m_authInfos = [NSMutableArray array];
    
    NSMutableDictionary *name = [NSMutableDictionary dictionary];
    name[@"key"] = @"name";
    name[@"placeholder"] = @"姓名";
    
    NSMutableDictionary *telephone = [NSMutableDictionary dictionary];
    telephone[@"key"] = @"telephone";
    telephone[@"placeholder"] = @"绑定手机号";
    telephone[@"keyboardType"] = @(UIKeyboardTypeNumberPad);
    
    NSMutableDictionary *idNumber = [NSMutableDictionary dictionary];
    idNumber[@"key"] = @"idNumber";
    idNumber[@"placeholder"] = @"身份证";
    idNumber[@"keyboardType"] = @(UIKeyboardTypeNumberPad);
    
    NSMutableDictionary *bankCardId = [NSMutableDictionary dictionary];
    bankCardId[@"key"] = @"bankCardId";
    bankCardId[@"placeholder"] = @"银行卡号";
    bankCardId[@"keyboardType"] = @(UIKeyboardTypeNumberPad);
    
    NSMutableDictionary *company = [NSMutableDictionary dictionary];
    company[@"key"] = @"company";
    company[@"placeholder"] = @"公司";
    
    [m_authInfos addObject:name];
    [m_authInfos addObject:telephone];
    [m_authInfos addObject:idNumber];
    [m_authInfos addObject:bankCardId];
    [m_authInfos addObject:company];
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
    if ([identifier isEqualToString:@"textField"])
    {
        return [self tableView:tableView textFieldCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"levelSelect"])
    {
        return [self tableView:tableView levelSelectCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"submitButton"])
    {
        return [self tableView:tableView submitButtonCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"blankCell"])
    {
        return [self tableView:tableView blankCellForIndex:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView levelSelectCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSInteger attachIndex = cellInfo.attachIndex;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCUserAuthLevelSelectView *cellView = [[HCUserAuthLevelSelectView alloc] initWithFrame:cell.contentView.frame];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSMutableDictionary *textFieldInfo = m_authInfos[attachIndex];
    
    HCUserAuthLevelSelectView *cellView = (HCUserAuthLevelSelectView *)cell.m_subContentView;
    [cellView setCurrentLevel:m_userLevel];
    
    return cell;
}

#pragma mark - HCUserAuthLevelSelectViewDelegate
-(void)didSelectLevel:(NSInteger)level cellView:(HCUserAuthLevelSelectView *)cellView
{
    m_userLevel = level;
    
    [m_inputInfo safeSetObject:@(m_userLevel) forKey:@"level"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView textFieldCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    NSInteger attachIndex = cellInfo.attachIndex;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCUserAuthTextInputCellView *cellView = [[HCUserAuthTextInputCellView alloc] initWithFrame:cell.contentView.frame];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    NSMutableDictionary *textFieldInfo = m_authInfos[attachIndex];
    
    HCUserAuthTextInputCellView *cellView = (HCUserAuthTextInputCellView *)cell.m_subContentView;
    cellView.index = attachIndex;
    [cellView setPlaceHolder:textFieldInfo[@"placeholder"]];
    
    UITextField *contentTextField = [cellView contentTextField];
    contentTextField.returnKeyType = UIReturnKeyDone;
    contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (textFieldInfo[@"keyboardType"])
    {
        NSInteger keyboardType = [(NSNumber *)textFieldInfo[@"keyboardType"] integerValue];
        contentTextField.keyboardType = keyboardType;
    }
    else
    {
        contentTextField.keyboardType = UIKeyboardTypeDefault;
    }
    
    NSString *inputValue = textFieldInfo[@"inputValue"];
    [contentTextField setText:inputValue];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView submitButtonCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        registerButton.frame = CGRectMake((CGRectGetWidth(cell.contentView.frame) - 270) /2 , 0, 270, CGRectGetHeight(cell.contentView.frame));
        registerButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [registerButton setTitle:@"提交" forState:UIControlStateNormal];
        [registerButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
        [registerButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
        [registerButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
        [registerButton addTarget:self action:@selector(onClickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:registerButton];
    }
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView blankCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
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
        separator.frame = CGRectMake(40, 0, CGRectGetWidth(cell.contentView.frame) - 80, MFOnePixHeight);
        separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        separator.backgroundColor = MFCustomLineColor;
        [cell.contentView addSubview:separator];
    }
    return cell;
}

#pragma mark - HCUserAuthTextInputCellViewDelegate
-(BOOL)userAuthTextInputCellView:(HCUserAuthTextInputCellView *)cellView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *contentTextField = [cellView contentTextField];
    
    NSString *content = contentTextField.text;
    
    if ([string isEqualToString:@"\n"]) {
        [contentTextField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)userAuthTextFieldEditChanged:(HCUserAuthTextInputCellView *)cellView
{
    UITextField *contentTextField = [cellView contentTextField];
    NSString *content = contentTextField.text;
    
    NSInteger attachIndex = cellView.index;
    
    NSMutableDictionary *textFieldInfo = m_authInfos[attachIndex];
    NSString *inputKey = textFieldInfo[@"key"];
    [m_inputInfo safeSetObject:content forKey:inputKey];
}

-(void)onClickSubmitButton
{
    if (![self checkSubmitInfo]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    HCUserAuthApi *mfApi = [HCUserAuthApi new];
    mfApi.telephone = m_inputInfo[@"telephone"];
    mfApi.name = m_inputInfo[@"name"];
    mfApi.idNumber = m_inputInfo[@"idNumber"];
    mfApi.idImageUrl = self.IdImageUrl;
    mfApi.city = m_inputInfo[@"city"];
    mfApi.bankCardId = m_inputInfo[@"bankCardId"];
    mfApi.company = m_inputInfo[@"company"];
    mfApi.level = m_inputInfo[@"level"];
    
    mfApi.animatingText = @"提交中...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            return;
        }
        
        NSDictionary *tokenInfo = mfApi.responseNetworkData;
        [strongSelf showTips:@"提交成功"];
        [strongSelf pushUserAuthSubmitSuccessVC];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

-(void)pushUserAuthSubmitSuccessVC
{
    HCUserAuthSubmitSuccessViewController *successVC = [HCUserAuthSubmitSuccessViewController new];
    successVC.m_delegate = self;
    [self.navigationController pushViewController:successVC animated:YES];
}

#pragma mark - HCUserAuthSubmitSuccessViewControllerDelegate
-(void)onClickUserAuthSubmitSuccess
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    NSInteger meVCIndex = 0;
    for (int i = 0; i < viewControllers.count; i++)
    {
        UIViewController *controller = viewControllers[i];
        if ([controller isKindOfClass:[HCMeViewController class]]) {
            meVCIndex = i;
            break;
        }
    }
    
    UIViewController *meVC = viewControllers[meVCIndex];
    [self.navigationController popToViewController:meVC animated:YES];
}


-(BOOL)checkSubmitInfo
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    NSString *telephone = m_inputInfo[@"telephone"];
    if (![MFStringUtil isBlankString:telephone] && ![loginService.userPhone isEqualToString:telephone]) {
        [self showTips:@"请输入登录的手机号"];
        return NO;
    }
    
    if ([MFStringUtil isBlankString:m_inputInfo[@"name"]])
    {
        [self showTips:@"请输入姓名"];
        return NO;
    }
    else if ([MFStringUtil isBlankString:m_inputInfo[@"telephone"]])
    {
        [self showTips:@"请输入手机号"];
        return NO;
    }
    else if ([MFStringUtil isBlankString:m_inputInfo[@"idNumber"]])
    {
        [self showTips:@"请输入身份证号码"];
        return NO;
    }
    else if ([MFStringUtil isBlankString:m_inputInfo[@"bankCardId"]])
    {
        [self showTips:@"请输入银行卡号码"];
        return NO;
    }
    else if ([MFStringUtil isBlankString:m_inputInfo[@"company"]])
    {
        [self showTips:@"请输入公司名"];
        return NO;
    }
    else if (!m_inputInfo[@"level"])
    {
        [self showTips:@"请选择认证级别"];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

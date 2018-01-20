//
//  HCUserAuthViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/19.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserAuthViewController.h"
#import "HCUserAuthApi.h"

@interface HCUserAuthViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray *m_authInfos;
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
    
    NSMutableDictionary *idNumber = [NSMutableDictionary dictionary];
    idNumber[@"key"] = @"idNumber";
    idNumber[@"placeholder"] = @"身份证";
    
    NSMutableDictionary *bankCardId = [NSMutableDictionary dictionary];
    bankCardId[@"key"] = @"bankCardId";
    bankCardId[@"placeholder"] = @"银行卡号";
    
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
        
    }
    else if ([identifier isEqualToString:@"levelSelect"])
    {
        
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

-(void)onClickSubmitButton
{
    NSLog(@"onClickSubmitButton");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

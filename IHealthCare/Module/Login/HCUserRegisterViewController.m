//
//  HCUserRegisterViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/2.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCUserRegisterViewController.h"
#import "HCUserRegisterHeaderView.h"

@interface HCUserRegisterViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate,HCUserRegisterHeaderViewDelegate>
{
    MFUITableView *m_tableView;
    NSMutableArray<MFTableViewCellObject *> *m_cellInfos;
    
    NSMutableArray *m_registerInfos;
}

@end

@implementation HCUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    [self setBackBarButton];
    
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_tableView.backgroundColor = [UIColor whiteColor];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.m_delegate = self;
    [self.view addSubview:m_tableView];
    
    m_cellInfos = [NSMutableArray array];
    [self initRegisterInfos];
    
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
    if ([identifier isEqualToString:@"avatar"])
    {
        return [self tableView:tableView avatarInfoCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"textField"])
    {
        return [self tableView:tableView textFieldCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"registerButton"])
    {
        return [self tableView:tableView registerCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"separator"])
    {
        return [self tableView:tableView separatorCellForIndex:indexPath];
    }
    else if ([identifier isEqualToString:@"blankCell"])
    {
        return [self tableView:tableView blankCellForIndex:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView avatarInfoCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HCUserRegisterHeaderView *cellView = [HCUserRegisterHeaderView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView textFieldCellForIndex:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, (CGRectGetWidth(cell.contentView.frame) - 110), CGRectGetHeight(cell.contentView.frame))];
        textField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        cell.m_subContentView = textField;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    NSMutableDictionary *registerInfo = m_registerInfos[attachIndex];
    
    UITextField *cellView = (UITextField *)cell.m_subContentView;
    cellView.frame = CGRectMake(55, 0, (CGRectGetWidth(cell.contentView.frame) - 110), CGRectGetHeight(cell.contentView.frame));
    cellView.tag = attachIndex;
    cellView.placeholder = registerInfo[@"placeholder"];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView registerCellForIndex:(NSIndexPath *)indexPath
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
        [registerButton addTarget:self action:@selector(onClickRegisterUser) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:registerButton];
    }
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
        separator.frame = CGRectMake(55, 0, CGRectGetWidth(cell.contentView.frame) - 110, MFOnePixHeight);
        separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        separator.backgroundColor = MFCustomLineColor;
        [cell.contentView addSubview:separator];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(void)makeCellObjects
{
    MFTableViewCellObject *avatar = [MFTableViewCellObject new];
    avatar.cellHeight = 170.0f;
    avatar.cellReuseIdentifier = @"avatar";
    [m_cellInfos addObject:avatar];
    
    for (int i = 0; i < m_registerInfos.count; i++)
    {
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
        
        if (i != m_registerInfos.count - 1)
        {
            MFTableViewCellObject *blank = [MFTableViewCellObject new];
            blank.cellHeight = 10.0f;
            blank.cellReuseIdentifier = @"blankCell";
            [m_cellInfos addObject:blank];
        }
    }
    
    MFTableViewCellObject *blank = [MFTableViewCellObject new];
    blank.cellHeight = 38.0f;
    blank.cellReuseIdentifier = @"blankCell";
    [m_cellInfos addObject:blank];
    
    MFTableViewCellObject *registerButton = [MFTableViewCellObject new];
    registerButton.cellHeight = 40.0f;
    registerButton.cellReuseIdentifier = @"registerButton";
    [m_cellInfos addObject:registerButton];
}

-(void)initRegisterInfos
{
    m_registerInfos = [NSMutableArray array];
    
    NSMutableDictionary *name = [NSMutableDictionary dictionary];
    name[@"key"] = @"name";
    name[@"placeholder"] = @"姓名";
    
    NSMutableDictionary *telephone = [NSMutableDictionary dictionary];
    telephone[@"key"] = @"telephone";
    telephone[@"placeholder"] = @"手机号";
    
    NSMutableDictionary *preUserphone = [NSMutableDictionary dictionary];
    preUserphone[@"key"] = @"preUserphone";
    preUserphone[@"placeholder"] = @"邀请人手机号";
    
    NSMutableDictionary *city = [NSMutableDictionary dictionary];
    city[@"key"] = @"city";
    city[@"placeholder"] = @"城市";
    
    [m_registerInfos addObject:name];
    [m_registerInfos addObject:telephone];
    [m_registerInfos addObject:preUserphone];
    [m_registerInfos addObject:city];
}

-(void)onClickRegisterUser
{
    NSLog(@"onClickHeadAvatarButton");
}

#pragma mark - HCUserRegisterHeaderViewDelegate
-(void)onClickHeadAvatarButton:(HCUserRegisterHeaderView *)view
{
    NSLog(@"onClickHeadAvatarButton");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

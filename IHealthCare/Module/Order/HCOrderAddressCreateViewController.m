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

@interface HCOrderAddressCreateViewController () <tableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
}

@end

@implementation HCOrderAddressCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建收货地址";
    [self setBackBarButton];
    
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
    
    MFTableViewCellObject *phone = [MFTableViewCellObject new];
    phone.cellReuseIdentifier = @"addressText";
    phone.attachKey = @"phone";
    phone.cellHeight = 70.0f;
    [m_cellInfos addObject:phone];
    
    MFTableViewCellObject *city = [MFTableViewCellObject new];
    city.cellReuseIdentifier = @"citySelect";
    city.attachKey = @"city";
    city.cellHeight = 70.0f;
    [m_cellInfos addObject:city];
    
    MFTableViewCellObject *addr = [MFTableViewCellObject new];
    addr.cellReuseIdentifier = @"addressText";
    addr.attachKey = @"addr";
    addr.cellHeight = 70.0f;
    [m_cellInfos addObject:addr];
    
    MFTableViewCellObject *defaultSet = [MFTableViewCellObject new];
    defaultSet.cellReuseIdentifier = @"defaultSet";
    defaultSet.attachKey = @"defaultSet";
    defaultSet.cellHeight = 70.0f;
    [m_cellInfos addObject:defaultSet];
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

-(void)onClickBottomButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

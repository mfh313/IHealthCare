//
//  HCUserAuthSubmitSuccessViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/20.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCUserAuthSubmitSuccessViewController.h"

@interface HCUserAuthSubmitSuccessViewController ()
{
    MMTableViewInfo *m_tableViewInfo;
}

@end

@implementation HCUserAuthSubmitSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"认证提交成功";
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:contentTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end

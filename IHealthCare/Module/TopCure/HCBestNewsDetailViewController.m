//
//  HCBestNewsDetailViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/30.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCBestNewsDetailViewController.h"
#import "HCBestNewsDetailModel.h"

@interface HCBestNewsDetailViewController ()

@end

@implementation HCBestNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BestNewsDetail";
    [self setBackBarButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

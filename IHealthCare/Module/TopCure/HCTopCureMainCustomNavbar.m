//
//  HCTopCureMainCustomNavbar.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/12.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCTopCureMainCustomNavbar.h"

@interface HCTopCureMainCustomNavbar ()
{
    __weak IBOutlet UIImageView *m_searchBgView;
    __weak IBOutlet UIImageView *m_searchIconView;
    __weak IBOutlet UILabel *m_locationLabel;
    __weak IBOutlet UIImageView *m_messageImageView;
}

@end

@implementation HCTopCureMainCustomNavbar

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    m_searchBgView.image = MFImageStretchCenter(@"home_bg_search_nor");
    m_searchIconView.image = MFImage(@"home_icon_search_nor");
    m_messageImageView.image = MFImage(@"title_btn_im_nor");
    
    m_searchBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSearchBgView)];
    [m_searchBgView addGestureRecognizer:tapGes];
}

-(void)onClickSearchBgView
{
    NSLog(@"onClickSearchBgView");
}

- (IBAction)onClickLocationButton:(id)sender {
    NSLog(@"onClickLocationButton");
}

- (IBAction)onClickMessageButton:(id)sender {
    NSLog(@"onClickMessageButton");
}

@end

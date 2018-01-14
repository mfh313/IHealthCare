//
//  HCClassRoomCourseDescriptionViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/14.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCClassRoomCourseDescriptionViewController.h"
#import "HCClassRoomDetailModel.h"

@interface HCClassRoomCourseDescriptionViewController () <MMTableViewInfoDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
}

@end

@implementation HCClassRoomCourseDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:contentTableView];
    
    [self reloadTableView];
}

-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    CGFloat cellHeight = [self textHeightForNewsDetail:self.detailModel.detail];
    
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:cellHeight
                                                               userInfo:nil];
    
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeDetailCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        cell.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
        
        UITextView *cellView = [[UITextView alloc] initWithFrame:cell.contentView.frame];
        cellView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
        cellView.font = [UIFont systemFontOfSize:16.0f];
        cellView.textColor = [UIColor hx_colorWithHexString:@"333333"];
        cellView.userInteractionEnabled = NO;
        cell.m_subContentView = cellView;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    UITextView *cellView = (UITextView *)cell.m_subContentView;
    cellView.frame = CGRectMake(20, 10, CGRectGetWidth(cell.contentView.frame) - 45, CGRectGetHeight(cell.contentView.frame) - 10);
    [cellView setText:self.detailModel.detail];
}

-(CGFloat)textHeightForNewsDetail:(NSString *)detail
{
    return [detail MMSizeWithFont:[UIFont systemFontOfSize:16.0f] maxSize:CGSizeMake(CGRectGetWidth(self.view.frame) - 45, CGFLOAT_MAX)].height + 40;
}

-(void)reloadCourseDescription
{
    [self reloadTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

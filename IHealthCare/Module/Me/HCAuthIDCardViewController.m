//
//  HCAuthIDCardViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/24.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCAuthIDCardViewController.h"
#import "HCAuthIDCardFacadeInputView.h"
#import "HCQiniuFileService.h"
#import "HCUserAuthViewController.h"

@interface HCAuthIDCardViewController () <HCAuthIDCardFacadeInputViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
    
    NSString *m_idImageUrl;
}

@property (nonatomic, strong) UIImage *pickImage;

@end

@implementation HCAuthIDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提交身份证";
    [self setBackBarButton];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:contentTableView];
    
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(contentTableView.frame), 10);
    tableHeaderView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.tableHeaderView = tableHeaderView;
    
    [self reloadTableView];
    
    [self setTableFooterView];
}

-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeIDCardImageCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:200.0
                                                               userInfo:nil];
    
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)setTableFooterView
{
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    
    UIView *tableFooterView = [UIView new];
    tableFooterView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    tableFooterView.frame = CGRectMake(0, 0, CGRectGetWidth(contentTableView.frame), 260);
    contentTableView.tableFooterView = tableFooterView;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [nextButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_nor") forState:UIControlStateNormal];
    [nextButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_press") forState:UIControlStateHighlighted];
    [nextButton setBackgroundImage:MFImageStretchCenter(@"common_btn_login_dis") forState:UIControlStateDisabled];
    [nextButton addTarget:self action:@selector(onClickNextButton) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(@(40));
        make.top.mas_equalTo(@(23));
        make.centerX.mas_equalTo(tableFooterView.mas_centerX);
    }];
}

- (void)makeIDCardImageCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCAuthIDCardFacadeInputView *cellView = [HCAuthIDCardFacadeInputView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;

        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCAuthIDCardFacadeInputView *cellView = (HCAuthIDCardFacadeInputView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    [cellView setIdImageUrl:m_idImageUrl];
}

#pragma mark - HCAuthIDCardFacadeInputViewDelegate
-(void)onClickContenButton:(HCAuthIDCardFacadeInputView *)view
{
    [self gotoImageLibrary];
}

-(void)onClickNextButton
{
    if ([MFStringUtil isBlankString:m_idImageUrl]) {
        [self showTips:@"请先上传身份证"];
        return;
    }
    
    HCUserAuthViewController *userAuthVC = [HCUserAuthViewController new];
    userAuthVC.IdImageUrl = m_idImageUrl;
    [self.navigationController pushViewController:userAuthVC animated:YES];
}

-(void)openCameraImagePickerController
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)gotoImageLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"访问图片库错误"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        [alert show];
    }
}

//再调用以下委托：
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    self.pickImage = image; //imageView为自己定义的UIImageView
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
    if (self.pickImage == nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"还未选择图片"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self uploadImageToQNiu:self.pickImage];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)uploadImageToQNiu:(UIImage *)image
{
    __weak typeof(self) weakSelf = self;
    [self showMBStatusInViewController:@"正在上传身份证..."];
    
    HCQiniuFileService *qiniuService = [[MMServiceCenter defaultCenter] getService:[HCQiniuFileService class]];
    [qiniuService uploadImageToQNiu:image complete:^(NSString *url, NSString *name)
    {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        m_idImageUrl = url;
        [strongSelf showTips:@"身份证上传成功"];
        [strongSelf reloadTableView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

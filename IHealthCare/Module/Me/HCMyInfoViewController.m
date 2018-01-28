//
//  HCMyInfoViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/18.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCMyInfoViewController.h"
#import "HCMyInfoAvtarCellView.h"
#import "HCMyInfoInputCellView.h"
#import "HCGetUserInfoApi.h"
#import "HCPutUserInfoApi.h"
#import "HCQiniuFileService.h"

@interface HCMyInfoViewController () <MMTableViewInfoDelegate,HCMyInfoInputCellViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
    
    BOOL m_canModifyPhone;
    
    NSString *m_imageUrl;
}

@property (nonatomic, strong) UIImage *pickImage;

@end

@implementation HCMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    [self setBackBarButton];
    [self setRightBarButtonTitle:@"保存"];
    
    m_tableViewInfo = [[MMTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    m_tableViewInfo.delegate = self;
    
    UITableView *contentTableView = [m_tableViewInfo getTableView];
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:contentTableView];
    
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(contentTableView.frame), 14);
    tableHeaderView.backgroundColor = [UIColor hx_colorWithHexString:@"F4F4F4"];
    contentTableView.tableHeaderView = tableHeaderView;
    
    [self getUserInfo];
}

-(void)getUserInfo
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCGetUserInfoApi *mfApi = [HCGetUserInfoApi new];
    mfApi.userTel = loginService.userPhone;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *responseNetworkData = mfApi.responseNetworkData;
        strongSelf.userInfo = [HCUserModel yy_modelWithDictionary:responseNetworkData];
        if ([MFStringUtil isBlankString:strongSelf.userInfo.preUserphone])
        {
            m_canModifyPhone = YES;
        }
        else
        {
            m_canModifyPhone = NO;
        }
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reloadTableView
{
    [m_tableViewInfo clearAllSection];
    
    [self addAvtarImageSection];
    [self addDetailInfoSection];
    
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *prePhone = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailInfoCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickDetailInfoCell:)
                                                           actionTarget:self
                                                                 height:50.0
                                                               userInfo:nil];
    [prePhone addUserInfoValue:@"prePhone" forKey:@"contentKey"];
    
    [sectionInfo addCell:prePhone];
    
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)addAvtarImageSection
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeAvtarImageCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickAvtarImageCell:)
                                                           actionTarget:self
                                                                 height:80.0
                                                               userInfo:nil];
    
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

-(void)addDetailInfoSection
{
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *nameInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailInfoCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickDetailInfoCell:)
                                                           actionTarget:self
                                                                 height:50.0
                                                               userInfo:nil];
    
    [nameInfo addUserInfoValue:@"name" forKey:@"contentKey"];
    
    MMTableViewCellInfo *phoneInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailInfoCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:@selector(onClickDetailInfoCell:)
                                                           actionTarget:self
                                                                 height:50.0
                                                               userInfo:nil];
    
    [phoneInfo addUserInfoValue:@"phone" forKey:@"contentKey"];

    
    MMTableViewCellInfo *cityInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeDetailInfoCell:cellInfo:)
                                                              makeTarget:self
                                                               actionSel:@selector(onClickDetailInfoCell:)
                                                            actionTarget:self
                                                                  height:50.0
                                                                userInfo:nil];
    
    [cityInfo addUserInfoValue:@"city" forKey:@"contentKey"];
    
    [sectionInfo addCell:nameInfo];
    [sectionInfo addCell:phoneInfo];
    [sectionInfo addCell:cityInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
}

- (void)makeDetailInfoCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HCMyInfoInputCellView *cellView = [[HCMyInfoInputCellView alloc] initWithFrame:cell.contentView.frame];
    cellView.m_delegate = self;
    cell.m_subContentView = cellView;
    
    NSString *contentKey =  [cellInfo getUserInfoValueForKey:@"contentKey"];
    
    UITextField *contentTextField = [cellView contentTextField];
    
    cellView.contentKey = contentKey;
    if ([contentKey isEqualToString:@"name"])
    {
        [cellView setLeftTitle:@"姓名" titleWidth:45];
        [cellView setTextFieldContent:self.userInfo.name placeHolder:@"请输入姓名"];
    }
    else if ([contentKey isEqualToString:@"phone"])
    {
        [cellView setLeftTitle:@"手机号" titleWidth:45];
        [cellView setShowContent:self.userInfo.telephone];
    }
    else if ([contentKey isEqualToString:@"city"])
    {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cellView setLeftTitle:@"城市" titleWidth:45];
        [cellView setShowContent:self.userInfo.address];
    }
    else if ([contentKey isEqualToString:@"prePhone"])
    {
        [cellView setLeftTitle:@"邀请人手机号" titleWidth:90];
        if (m_canModifyPhone)
        {
            contentTextField.keyboardType = UIKeyboardTypeNumberPad;
            [cellView setTextFieldContent:self.userInfo.preUserphone placeHolder:@"请输入邀请人手机号"];
        }
        else
        {
            [cellView setShowContent:self.userInfo.preUserphone];
        }
    }
}

-(void)onClickDetailInfoCell:(MMTableViewCellInfo *)cellInfo
{
    NSString *contentKey =  [cellInfo getUserInfoValueForKey:@"contentKey"];
    if ([contentKey isEqualToString:@"city"])
    {
        NSArray *cityArray = @[@"深圳市",@"北京市",@"上海市",@"广州市"];
        
        __weak typeof(self) weakSelf = self;
        LGAlertView *alertView = [LGAlertView alertViewWithTitle:nil message:nil style:LGAlertViewStyleActionSheet buttonTitles:cityArray cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            NSString *value = cityArray[index];
            strongSelf.userInfo.address = value;
            
            [self reloadTableView];
            
        } cancelHandler:^(LGAlertView * _Nonnull alertView) {
            
        } destructiveHandler:nil];
        
        [alertView showAnimated:YES completionHandler:nil];
    }
}

- (void)makeAvtarImageCell:(MFTableViewCell *)cell cellInfo:(MMTableViewCellInfo *)cellInfo
{
    if (!cell.m_subContentView) {
        HCMyInfoAvtarCellView *cellView = [HCMyInfoAvtarCellView nibView];
        cell.m_subContentView = cellView;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    else
    {
        [cell.contentView addSubview:cell.m_subContentView];
    }
    
    HCMyInfoAvtarCellView *cellView = (HCMyInfoAvtarCellView *)cell.m_subContentView;
    cellView.frame = cell.contentView.bounds;
    
    [cellView setAvtarImageUrl:self.userInfo.imageUrl];
}

-(void)onClickAvtarImageCell:(MMTableViewCellInfo *)cellInfo
{
    NSArray *actionArray = @[@"拍照",@"从手机相册选择"];
    
    __weak typeof(self) weakSelf = self;
    LGAlertView *alertView = [LGAlertView alertViewWithTitle:nil message:nil style:LGAlertViewStyleActionSheet buttonTitles:actionArray cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView * _Nonnull alertView, NSUInteger index, NSString * _Nullable title) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (index == 0)
        {
            [strongSelf openCameraImagePickerController];
        }
        else if (index == 1)
        {
            [strongSelf openImageLibrary];
        }
        
    } cancelHandler:^(LGAlertView * _Nonnull alertView) {
        
    } destructiveHandler:nil];
    
    [alertView showAnimated:YES completionHandler:nil];
}

-(void)onClickRightButton:(id)sender
{
    HCLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[HCLoginService class]];
    
    __weak typeof(self) weakSelf = self;
    HCPutUserInfoApi *mfApi = [HCPutUserInfoApi new];
    mfApi.name = self.userInfo.name;
    mfApi.telephone = self.userInfo.telephone;
    mfApi.address = self.userInfo.address;
    mfApi.imageUrl = m_imageUrl;
    mfApi.preUserphone = self.userInfo.preUserphone;
    
    mfApi.animatingView = self.view;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSDictionary *responseNetworkData = mfApi.responseNetworkData;
        
        strongSelf.userInfo = [HCUserModel yy_modelWithDictionary:responseNetworkData];
        [strongSelf showTips:@"修改成功"];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

#pragma mark - HCMyInfoInputCellViewDelegate
-(BOOL)inputCellView:(HCMyInfoInputCellView *)cellView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *contentTextField = [cellView contentTextField];
    
    NSString *content = contentTextField.text;
    
    if ([string isEqualToString:@"\n"]) {
        [contentTextField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)inputCellViewEditChanged:(HCMyInfoInputCellView *)cellView
{
    UITextField *contentTextField = [cellView contentTextField];
    NSString *content = contentTextField.text;
    
    NSString *contentKey = cellView.contentKey;
    if ([contentKey isEqualToString:@"name"]) {
        self.userInfo.name = content;
    }
    else if ([contentKey isEqualToString:@"prePhone"])
    {
        self.userInfo.preUserphone = content;
    }
}

-(void)openCameraImagePickerController
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)openImageLibrary
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
                  editingInfo:(NSDictionary *)editingInfo
{
    self.pickImage = image;
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

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)uploadImageToQNiu:(UIImage *)image
{
    __weak typeof(self) weakSelf = self;
    [self showMBStatusInViewController:@"正在更新头像..."];
    
    HCQiniuFileService *qiniuService = [[MMServiceCenter defaultCenter] getService:[HCQiniuFileService class]];
    [qiniuService uploadImageToQNiu:image complete:^(NSString *url, NSString *name)
     {
         __strong typeof(weakSelf) strongSelf = weakSelf;
         [strongSelf hiddenMBStatus];
         
         m_imageUrl = url;
         strongSelf.userInfo.imageUrl = m_imageUrl;
         [strongSelf reloadTableView];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

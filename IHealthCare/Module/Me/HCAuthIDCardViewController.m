//
//  HCAuthIDCardViewController.m
//  IHealthCare
//
//  Created by mafanghua on 2017/12/24.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "HCAuthIDCardViewController.h"
#import "HCAuthIDCardFacadeInputView.h"
#import "HCGetQiniuUpImageTokenApi.h"
#import <QiniuSDK.h>

@interface HCAuthIDCardViewController () <HCAuthIDCardFacadeInputViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
}

@property (nonatomic, strong) NSString *token;
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
    
    MMTableViewSectionInfo *sectionInfo = [MMTableViewSectionInfo sectionInfoDefault];
    
    MMTableViewCellInfo *cellInfo = [MMTableViewCellInfo cellForMakeSel:@selector(makeIDCardImageCell:cellInfo:)
                                                             makeTarget:self
                                                              actionSel:nil
                                                           actionTarget:self
                                                                 height:200.0
                                                               userInfo:nil];
    
    [sectionInfo addCell:cellInfo];
    
    [m_tableViewInfo addSection:sectionInfo];
    
    [self setTableFooterView];
    
    [self getUPImageToken];
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
}

#pragma mark - HCAuthIDCardFacadeInputViewDelegate
-(void)onClickContenButton:(HCAuthIDCardFacadeInputView *)view
{
    [self gotoImageLibrary];
}

-(void)onClickNextButton
{
    NSLog(@"onClickNextButton");
}

- (void)gotoImageLibrary {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
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
    } else {
        [self uploadImageToQNFilePath:[self getImagePath:self.pickImage]];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImageToQNFilePath:(NSString *)filePath {
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    [upManager putFile:filePath key:nil token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
    }
                option:uploadOption];
}

//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

-(void)getUPImageToken
{
    __weak typeof(self) weakSelf = self;
    HCGetQiniuUpImageTokenApi *mfApi = [HCGetQiniuUpImageTokenApi new];
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        strongSelf.token = mfApi.responseNetworkData;
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

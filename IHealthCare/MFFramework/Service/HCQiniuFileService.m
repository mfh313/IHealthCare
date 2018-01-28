//
//  HCQiniuFileService.m
//  IHealthCare
//
//  Created by mafanghua on 2018/1/19.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "HCQiniuFileService.h"
#import "HCGetQiniuUpImageTokenApi.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HCQiniuFileService

-(void)getImageToken
{
    __weak typeof(self) weakSelf = self;
    HCGetQiniuUpImageTokenApi *mfApi = [HCGetQiniuUpImageTokenApi new];
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            return;
        }
        
        NSDictionary *tokenInfo = mfApi.responseNetworkData;
        strongSelf.token = tokenInfo[@"upToken"];
        strongSelf.bucketUrl = tokenInfo[@"bucketUrl"];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
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

-(void)uploadImageToQNiu:(UIImage *)image complete:(HCQiniuFileServiceHandler)completion
{
    [self uploadImageToQNFilePath:[self getImagePath:image] complete:completion];
}

- (void)uploadImageToQNFilePath:(NSString *)filePath complete:(HCQiniuFileServiceHandler)completion
{
    NSString *Md5_key = [[self fileNameForKey:[self randomString]] stringByAppendingString:@".png"];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    [upManager putFile:filePath key:Md5_key token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        if (completion) {
            NSString *url = [self.bucketUrl stringByAppendingPathComponent:resp[@"key"]];
            completion(url,resp[@"key"]);
        }
    }
                option:uploadOption];
}

-(NSString *)randomString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSXXX"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *titleName = [formatter stringFromDate:[NSDate date]];
    return titleName;
}

- (NSString *)fileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], [[key pathExtension] isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", [key pathExtension]]];
    
    return filename;
}

@end

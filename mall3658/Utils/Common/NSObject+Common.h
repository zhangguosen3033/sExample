//
//  NSObject+Common.h
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/8.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Common)
#pragma mark Tip M
- (NSString *)tipFromError:(NSError *)error;
- (BOOL)showError:(NSError *)error;
- (void)showHudTipStr:(NSString *)tipStr;

//
//- (void)showStatusBarQueryStr:(NSString *)tipStr;
//- (void)showStatusBarSuccessStr:(NSString *)tipStr;
//- (void)showStatusBarError:(NSError *)error;
//- (void)showStatusBarProgress:(CGFloat)progress;
//- (void)hideStatusBarProgress;

//#pragma mark File M
////获取fileName的完整地址
//+ (NSString* )pathInCacheDirectory:(NSString *)fileName;
////创建缓存文件夹
//+ (BOOL)createDirInCache:(NSString *)dirName;
//
////图片
//+ (BOOL)saveImage:(UIImage *)image imageName:(NSString *)imageName inFolder:(NSString *)folderName;
//+ (NSData*)loadImageDataWithName:( NSString *)imageName inFolder:(NSString *)folderName;
//+ (BOOL)deleteImageCacheInFolder:(NSString *)folderName;
//
////网络请求
//+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;//缓存请求回来的json对象
//+ (id)loadResponseWithPath:(NSString *)requestPath;//返回一个NSDictionary类型的json数据
//+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath;
//+ (BOOL)deleteResponseCache;

#pragma mark NetError
-(id)handleResponse:(id)responseJSON;
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;

- (void)checkAppUpdate;

@end

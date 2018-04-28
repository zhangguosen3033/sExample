//
//  UIImage(ZHTools).h
//  FrameWork
//
//  Created by 于兆海 (QQ:695885883) on 2016/10/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(ZHTools)

+ (UIImage *)zh_CaptureView:(UIView *)view;

+ (UIImage *)zh_CaptureScrollView:(UIScrollView *)view;

+ (UIImage *)zh_ImageWithColor:(UIColor *)color;
+ (UIImage *)zh_ImageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)zh_ImageNamed:(NSString *)name;

+ (UIImage *)zh_ImageNamed:(NSString *)name inBundle:(NSBundle *)bundle;

- (UIImage *)zh_ScaleToSize:(CGSize)targetSize;

- (UIImage *)zh_ScaleToWidth:(CGFloat)width;

- (UIImage *)zh_ScaleToHeight:(CGFloat)height;

@end

//
//  UIColor(ZHTools).h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/9/25.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView(ZHTools)

- (UIView * (^)(BOOL))zh_setHidden;

- (UIView * (^)(CGRect))zh_setFrame;

- (UIView * (^)(NSInteger))zh_setTag;

- (UIView * (^)(CGFloat))zh_setBorderWidth;

- (UIView * (^)(BOOL))zh_setClipsToBounds;

- (UIView * (^)(CGFloat))zh_setCornerRadius;

- (UIView * (^)(UIColor *))zh_setBorderColor;

- (UIView * (^)(UIColor *))zh_setBackgroundColor;

- (UIView * (^)(BOOL))zh_setUserInteractionEnabled;

- (UIView * (^)(UIViewContentMode))zh_setContentMode;

- (UIView * (^)(void))zh_removeFromSuperview;

- (UIView * (^)(UIView *))zh_addToSuperview;

#pragma mark -  添加UIBezierPath圆角绘制相关属性
- (CGFloat)zh_CornerRadius;
- (UIRectCorner)zh_Corners;

/**
 添加圆角 使用UIBezierPath提升效率（例：view.zh_AddCornerRadiusWithCorners(10, UIRectCornerAllCorners)）
 */
- (UIView * (^)(CGFloat, UIRectCorner))zh_AddCornerRadiusWithCorners;

/**
 添加圆角 使用UIBezierPath提升效率  corner传值：(UIRectCornerBottomLeft | UIRectCornerBottomRight)
 */
- (void)addZH_CornerRadius:(float)cornerRadius withZH_Corners:(UIRectCorner)corners;

@end

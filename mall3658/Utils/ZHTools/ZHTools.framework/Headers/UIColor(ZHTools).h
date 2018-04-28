//
//  UIColor(ZHTools).h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/9/25.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor(ZHTools)

/*!
 *
 *  @brief  随机色
 *
 */
+ (UIColor *)zh_RandomColor;

/*!
 *
 *  @brief  构造一个色值,参数样式：0xff8800
 *
 */
+ (UIColor *)zh_ColorWithHex:(UInt32)hex;

/*!
 *
 *  @brief  构造一个色值,参数样式：0xff8800
 *
 */
+ (UIColor *)zh_ColorWithHex:(UInt32)hex alpha:(float)alpha;

/*!
 *
 *  @brief  构造一个色值，字符串样式可以使一下任意一种：0xffffff、0X000000、#000000、000000
 */
+ (UIColor *)zh_ColorWithHexString:(NSString *)hexString;

/*!
 *
 *
 *  @brief  构造一个色值，字符串样式可以使一下任意一种：0xffffff、0X000000、#000000、000000
 *
 */
+ (UIColor *)zh_ColorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

//
//  NSString(ZHTools).h
//  FrameWork
//
//  Created by 于兆海 (QQ:695885883) on 2016/9/29.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(ZHTools)


/*!
*
*  @brief  计算指定字体、宽度、行距下文本的高度
*
*/
- (CGFloat)zh_HeightWithFont:(UIFont *)font width:(CGFloat)width lineSpace:(NSInteger)lineSpace;

/*!
 *
 *  @brief  计算指定字体、宽度下文本的高度
 *
 */
- (CGFloat)zh_HeightWithFont:(UIFont *)font width:(CGFloat)width;

/*!
 *
 *  @brief  计算指定字体、高度下文本的宽度
 *
 */
- (CGFloat)zh_WidthWithFont:(UIFont *)font height:(CGFloat)height;

/*!
 *
 *  @brief  去除空格后的字符串
 *
 */
- (NSString *)zh_TrimedStringByWhitespace;

/*!
 *
 *  @brief  去除空格与空行后的字符串
 *
 */
- (NSString *)zh_TrimedStringByWhitespaceAndNewlines;

/*!
 *
 *  @brief  JSON字符串转NSDictionary
 *
 */
- (NSDictionary *)zh_DictionaryValue;

/*!
 *
 *  @brief  NSDictionary转JSON字符串
 *
 */
+ (NSString *)zh_JsonStringFromDictionary:(NSDictionary *)dictionary;

/*!
 *
 *  @brief  判断字符串是否包含汉字
 *
 */
- (BOOL)zh_IsContainChineseCharacter;

@end

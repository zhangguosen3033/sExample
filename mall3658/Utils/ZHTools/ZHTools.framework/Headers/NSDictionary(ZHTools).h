//
//  NSDictionary+ZHTools.h
//  FrameWork
//
//  Created by 于兆海 (QQ:695885883) on 2016/10/28.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 *
 *  @brief  NSDictionary 工具类
 *
 */
@interface NSDictionary (ZHTools)

/**
 遍历
 */
- (void)zh_Each:(void (^)(id key, id value))block;

/**
 NSDictionary转换成JSON字符串
 */
- (NSString *)zh_JsonStringValue;

/**
 @
 */
- (id)zh_Value4Key:(NSString *)key;


/**
 若key对应的值为NSNumber类型，返回stringValue
 */
- (NSString *)zh_String4Key:(NSString *)key;

@end

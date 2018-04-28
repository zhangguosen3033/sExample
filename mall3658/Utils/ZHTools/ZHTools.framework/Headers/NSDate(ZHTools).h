//
//  NSDate(ZHTools).h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/9/27.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(ZHTools)

@property (readonly, nonatomic) NSInteger zh_Year;

/**
 *
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 */
@property (readonly, nonatomic) NSInteger zh_Month;

@property (readonly, nonatomic) NSInteger zh_Day;

@property (readonly, nonatomic) NSInteger zh_Hour;

@property (readonly, nonatomic) NSInteger zh_Minute;

@property (readonly, nonatomic) NSInteger zh_Second;

/**
 *
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 *
 */
@property (readonly, nonatomic) NSInteger zh_Weekday;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)zh_IsLeapYear;

- (BOOL)zh_IsEarlierThanDate:(NSDate *)aDate;

- (BOOL)zh_IsLaterThanDate:(NSDate *)aDate;

- (NSUInteger)zh_DaysInYear;

- (NSUInteger)zh_DaysInMonth;

- (NSDate *)zh_BeginningOfDay;

- (NSDate *)zh_EndOfDay;

- (NSDate *)zh_BeginningOfWeek;

- (NSDate *)zh_EndOfWeek;

- (NSDate *)zh_BeginningOfMonth;

- (NSDate *)zh_EndOfMonth;

- (NSDate *)zh_BeginningOfYear;

- (NSDate *)zh_EndOfYear;

@end

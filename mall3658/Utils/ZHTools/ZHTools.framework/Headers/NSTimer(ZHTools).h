//
//  NSTimer(ZHTools).h
//  FrameWork
//
//  Created by 于兆海 (QQ:695885883) on 2016/10/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZHTimerBlock)(NSTimer *timer);

@interface NSTimer(ZHTools)

+ (NSTimer *)zh_ScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(ZHTimerBlock)block repeats:(BOOL)repeats;

/**
 暂停,调用此方法后NStimer原有的isValid属性不再准确，请使用zh_IsValid
 */
- (void)zh_Pause;

/**
 开始,调用此方法后NStimer原有的isValid属性不再准确，请使用zh_IsValid
 */
- (void)zh_Resume;


/**
 NStimer原有的isValid属性不再准确，请使用zh_IsValid
 */
- (BOOL)zh_IsValid;

@end

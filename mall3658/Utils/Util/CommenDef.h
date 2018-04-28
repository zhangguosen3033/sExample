//
//  CommenDef.h
//  shMetro3.0
//
//  Created by syzhou on 13-4-12.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//
#import "Toolkit.h"
#ifndef BestOne_CommenDef_h
#define BestOne_CommenDef_h

#define NavigationBar_HEIGHT 44
#define StatusBar_HEIGHT CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame])


#define ratio_width ([UIScreen mainScreen].bounds.size.width)/375.0

#define ratio_Height ([UIScreen mainScreen].bounds.size.height)/667.0

#define ratio_height ([UIScreen mainScreen].bounds.size.height)/667.0


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SAFE_RELEASE(x) [x release];x=nil
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])


#define remove_sp(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
#define get_sp(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define get_Dsp(key) [[NSUserDefaults standardUserDefaults]dictionaryForKey:key]
#define set_sp(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]
#define sp [NSUserDefaults standardUserDefaults]
#define img(a) [UIImage imageNamed:a]
#define _app_ ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define _missions_ [Missions sharedManager]
 
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

#define RGB(a, b, c) [UIColor colorWithRed:(a) / 255.0 green:(b) / 255.0 blue:(c) / 255.0 alpha:1.0]

#define HUDShowTimeInterval 0.5

#define JsonStr(value)  [Toolkit toStringWithJsonValue:(value)]

#define hex_red_color @"ff4c4d"
#define hex_f3f3f3 @"f3f3f3"
#define hex_e5e5e5 @"e5e5e5"
#define hex_cccccc @"cccccc"
#define hex_aaaaaa @"aaaaaa"
#define hex_606060 @"606060"
#define hex_888888 @"888888"
#define hex_282828 @"282828"
#define hex_blue @"507daf"
#define hex_ff3618 @"ff3618"
#define hex_ffffff @"ffffff"
#define hex_1D85FF @"ff8b00"
#define hex_faf9f9 @"faf9f9"
#define hex_ff8800 @"ff8800"
#define hex_3e83ff @"3e83ff"
#define hex_DCDCDC @"DCDCDC"
//use dlog to print while in debug model
//#ifdef DEBUG
//#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//#   define DLog(...)
//#endif


#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif


//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]



#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }


#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define ITTDEBUG
#define ITTLOGLEVEL_INFO     10
#define ITTLOGLEVEL_WARNING  3
#define ITTLOGLEVEL_ERROR    1

#ifndef ITTMAXLOGLEVEL

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif

// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)  ((void)0)
#endif

#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
ITTDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define ITTDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif

#define ITTAssert(condition, ...)                                       \
do {                                                                      \
if (!(condition)) {                                                     \
[[NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                             \
}                                                                       \
} while(0)



#define _po(o) DLOG(@"%@", (o))
#define _pn(o) DLOG(@"%d", (o))
#define _pf(o) DLOG(@"%f", (o))
#define _ps(o) DLOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) DLOG(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)

#define DOBJ(obj)  DLOG(@"%s: %@", #obj, [(obj) description])

#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)

#pragma mark - yu

#define kGroupHeaderIcom_img @"GroupHeaderIcomSmall"
#define KUserHeaderIcon_NameStr  @"userHeaderIconSmall"
#define KCoreLock @"coreLock"
#define KCoreLockVCFromWhere @"coreLockVCFromLaunchScreen"
#define KCoreLockWillSetting @"coreLockWillSetting"
#define KUserIDForJudgeContinuousLogin  @"userIDForJudgeContinuousLogin"

#define kCoreLockShareBackToHere @"kCoreLockShareBackToHere"
#define KCoreLockPayMoneyBackToHere  @"kCoreLockPayMoneyBackToHere"
#define KCoreLockCallTelePhoneBackToHere @"kCoreLockCallTelePhoneBackToHere"
#define KCoreIsOffline @"KCoreIsOffline"
#define KCoreIsOfflineBaiNa @"KCoreIsOfflineBaiNa"
#define kDeviceID @"AppDeviceID"

#if IsEnterprise == 1
#define KAppScheme @"hzbyangsu"
#define kWXAppID @"wx4ce9b3788d6469d6"
#define kWXAppSecret @"4f136f01737b20ea3429aef136e8163f"
#define kQQAppID @"1105773620"
#define kQQAppKey @"BrSQrtpqRwuTOCS8"
#else
#define KAppScheme @"hzbappstore"
#define kWXAppID @"wx70989952a1157884"
#define kWXAppSecret @"78ef78e0f4958b34b32e0be3fe6730e3"
#define kQQAppID @"1105700179"
#define kQQAppKey @"fzlMM9wCxEzH6eRx"
#endif


//通知交易大厅的TabVC返回App首页
#define KTradingFloorRebackToAppHomeNotifacation @"tradingFloorRebackToAppHomeNotifacation"

#define kNewVersionFlag @"kNewVersionFlag"
/**
 *   判断是手机还是iPad 及其 手机的尺寸
 */
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_HEIGHT < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_HEIGHT == 736.0)

#define kDevice_Is_iPhoneX (IS_IPHONE && SCREEN_HEIGHT == 812)

#define TabBar_HEIGHT (kDevice_Is_iPhoneX ? 83 : 49)

#define NAV_MAXY (NavigationBar_HEIGHT + StatusBar_HEIGHT)
#define SAFE_AREA_HEIGHT (SCREEN_HEIGHT - NAV_MAXY - TabBar_HEIGHT)

#define kPaddingBelowSafeArea (kDevice_Is_iPhoneX ? 34 : 0)

#endif

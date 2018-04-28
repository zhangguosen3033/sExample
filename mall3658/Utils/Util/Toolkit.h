//
//  Toolkit.h
//  Blinq
//
//  Created by Sugar on 13-8-27.
//  Copyright (c) 2013年 Sugar Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Toolkit : NSObject

//+ (NSString *)getSystemLanguage;
//+ (void)setSystemLanguage:(NSString *)strLanguage;
+ (BOOL)isEnglishSysLanguage;
+ (BOOL)isSystemIOS7;
+(BOOL)isSystemIOS8;
// + (UIImage *)drawsimiLine:(UIImageView *)imageView;
//+ (void)setExtraCellLineHidden: (UITableView *)tableView; //隐藏多余的seperator

+ (NSString *)base64EncodedStringFrom:(NSData *)data;
+( UIColor *) getColor:( NSString *)hexColor;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 *  验证手机号是否合法
 *
 *  @param mobile 手机号字符串
 *
 *  @return true为合法，false为非法
 */
+(BOOL) isValidateMobile:(NSString *)mobile;

+ (NSString *)md5:(NSString *)str;



+(NSString*)toDivideNumberHJB:(NSString*)num;
+(NSString*)toDivideNumberRMB:(NSString *)num;

+ (NSString *)getCurrentAppVersion;



+(NSString*)formatSecondToData:(NSInteger)seconds;

/**
 *  转换用户名 将  m18653531862  转换为m186****1862
 *
 *  @param username
 *
 *  @return
 */
+(NSString*)formatCommentUsername:(NSString*)username;
/**
 *  Iphone6尺寸一下的文字字号大小递减一
 *
 *  @param font iphone6下的字号大小
 *
 *  @return 目标尺寸手机字号大小
 */
+ (UIFont *)getTextFontIphone6FollowingDecreasingWith:(CGFloat)font;

/**
 通过类对象来判断是否是第一次进入该类
 
 @param className 类对象
 
 @return YES 第一次进入该类  NO 非第一次
 */
+ (BOOL)isFirstEnterThisClass:(id)className;
/**
 通过类对象来判断密码格式是否正确
 
 @param passWordName 密码
 
 @return 如果返回为空，密码格式正确，否则格式错误，返回错误信息。
 */
+ (NSString*)isOrNoPasswordStyle:(NSString *)passWordName;

/*!
 @brief 修正浮点型精度丢失，开发中处理处理数字、价格金额等问题时, 后台经常返回float类型, 打印或转成NSString都会有精度丢失问题, 因此使用系统自带的NSDecimalNumber做处理, 能解决这问题
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+(NSString *)reviseString:(NSString *)str;

+ (BOOL) checkCardNo:(NSString*) cardNo;

+ (void)setContentInsetAdjustmentBehaviorNever4ScrollView:(UIScrollView *)scrollView;

/**
 json解析 统一将取得的字段转换为string
 */
+(NSString *)toStringWithJsonValue:(id)value;

+ (UIViewController *)topViewController;

+ (UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)targetSize;

+ (void)gotoSignIn;

/**
 给控件加一个圆角
 
 @param cornerRadius 圆角数值
 @param view 控件
 */
+ (void)addCornerRadius:(float)cornerRadius toView:(UIView *)view;

#pragma mark - 截图
+ (UIImage *)zh_CaptureView:(UIView *)view;

/*!
 *  @Author 于兆海
 *
 *  @brief  传入一张背景图、二维码图片、文本，生成一张图片传值规范：必须是UIView(或其子类)或键值对(键必须是由控件frame构造的字符串，值必须是UIImage或者NSAttributedString)
 *
 *  @param 背景图 & 二维码图片、文本、view
 */
+ (UIImage *)imageWithBackGroundImage:(UIImage *)image contents:(NSArray *)contents;

+ (NSMutableDictionary *)dictionaryFromURLString:(NSString *)urlString;

@end

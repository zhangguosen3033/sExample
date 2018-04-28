//
//  Toolkit.m
//  Blinq
//
//  Created by Sugar on 13-8-27.
//  Copyright (c) 2013年 Sugar Hou. All rights reserved.
//

#import "Toolkit.h"
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access
@implementation Toolkit

+ (BOOL)isSystemIOS7
{
    
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0&&[[[UIDevice currentDevice] systemVersion] floatValue] < 8.0? YES : NO;
}
+ (BOOL)isSystemIOS8
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO;
}
//+ (NSString *)getSystemLanguage
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:kSystemLanguage];
//}
//
//+ (void)setSystemLanguage:(NSString *)strLanguage
//{
//    if (strLanguage)
//        [[NSUserDefaults standardUserDefaults] setObject:strLanguage forKey:kSystemLanguage];
//}

//+(UIImage *)drawsimiLine:(UIImageView *)imageView
//{
//    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
//    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
//
//    CGFloat lengths[] = {5,5};
//    CGContextRef line = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(line, [UIColor whiteColor].CGColor);
//
//    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
//    CGContextMoveToPoint(line, 0.0, 20.0);    //开始画线
//    CGContextAddLineToPoint(line, 310.0, 20.0);
//    CGContextStrokePath(line);
//
//    return UIGraphicsGetImageFromCurrentImageContext();
//}

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

//+ (void)setExtraCellLineHidden: (UITableView *)tableView
//{
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor clearColor];
//    [tableView setTableFooterView:view];
//}

+ (BOOL)isEnglishSysLanguage
{
    return NO;
    //return [[self getSystemLanguage] isEqualToString:kEnglish] ? YES : NO;
}
+( UIColor *) getColor:( NSString *)hexColor

{
    
    unsigned int red, green, blue;
    
    NSRange range;
    
    range. length = 2 ;
    
    range. location = 0 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&red];
    
    range. location = 2 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&green];
    
    range. location = 4 ;
    
    [[ NSScanner scannerWithString :[hexColor substringWithRange :range]] scanHexInt :&blue];
    
    return [ UIColor colorWithRed :( float )(red/ 255.0f ) green :( float )(green/ 255.0f ) blue :( float )(blue/ 255.0f ) alpha : 1.0f ];
    
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


/**
 *  验证手机号是否合法
 *
 *  @param mobile 手机号字符串
 *
 *  @return true为合法，false为非法
 */
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

//私有方法，将字符串转化为md5
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+(NSString*)toDivideNumberHJB:(NSString*)num{
    //    NSInteger len=[num length];
    //    NSInteger yu=len%3;
    //    NSInteger ci=len/3;
    //
    //    NSMutableString*mStr=[NSMutableString string];
    //    for (int i=0; i<ci; i++) {
    //
    //    }
    return nil;
}
+(NSString*)toDivideNumberRMB:(NSString *)num{
    return nil;
}

+ (NSString *)getCurrentAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    
    // app名称
    
    //    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    // app版本
    
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    // app build版本
    
    //    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Version;
}

+(NSString*)formatSecondToData:(NSInteger)seconds{
    NSString* time;
    if (seconds<60*60*24) {//不足一天时的显示
        NSInteger hour=seconds/(60*60);
        NSInteger min=(seconds -hour*60*60)/60;
        NSInteger second=seconds%60;
        time=[NSString stringWithFormat:@"%ld小时%ld分%ld秒",hour,min,second];
    }
    else if(seconds<60*60*1)//不足一小时
    {
        
        NSInteger min=seconds/60;
        NSInteger second=seconds%60;
        time=[NSString stringWithFormat:@"%ld分%ld秒",min,second];
        
    }else if(seconds<60*1)//不足一分钟
    {
        NSInteger second=seconds%60;
        time=[NSString stringWithFormat:@"%ld秒",second];
    }else{
        
        NSInteger day=seconds/(60*60*24);
        NSInteger hour=(seconds-day*24*60*60)/(60*60);
        NSInteger min=(seconds -day*24*60*60-hour*60*60)/60;
        NSInteger second=seconds%60;
        time=[NSString stringWithFormat:@"%ld天%ld小时%ld分%ld秒",day,hour,min,second];
    }
    return time;
}

+(NSString*)formatCommentUsername:(NSString*)username{
    NSString *usernameRegex = @"^[A-Za-z]{1}\\d{11}$+$";
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegex];
    if ([usernameTest evaluateWithObject:username]) {
        username=[username stringByReplacingCharactersInRange:NSMakeRange(4, 4) withString:@"****"];
    }
    
    return username;
}


+ (UIFont*)getTextFontIphone6FollowingDecreasingWith:(CGFloat)font {
    CGFloat tempFont;
    if (IS_IPHONE) {
            if (IS_IPHONE_4_OR_LESS) {
                tempFont = font-2;
            }else if (IS_IPHONE_5) {
                tempFont = font-1;
            }else if (IS_IPHONE_6) {
                tempFont = font;
            }else if (IS_IPHONE_6P) {
                tempFont = font;
            }else {
                tempFont = font;
            }
        }else {
            tempFont = font;
        }
    return [UIFont systemFontOfSize:tempFont];
}

+ (BOOL)isFirstEnterThisClass:(id)className {
    
    NSString *classNameString =  [NSString stringWithUTF8String:object_getClassName(className)];
    
    BOOL exists = [[NSUserDefaults standardUserDefaults] boolForKey:classNameString];
    
    if (!exists) {
        //第一次进入该类
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:classNameString];
        return YES;
    }else{
        //非第一次进入该类
        return NO;
    }
}
+ (NSString*)isOrNoPasswordStyle:(NSString *)passWordName
{
    NSString * message;
    if (passWordName.length<8) {
        message=@" 密码不能少于8位，请您重新输入";
        
    }
    else if (passWordName.length>20)
    {
        message=@"密码最大长度为20位，请您重新输入";
    }
    else if ([self JudgeTheillegalCharacter:passWordName])
    {
        message=@"密码不能包含特殊字符，请您重新输入";
        
    }
    else if (![self judgePassWordLegal:passWordName])
    {
        message=@"密码必须为8-20位字母加数字组合，请您重新输入";
    }
    return message;
    
}
+(BOOL)JudgeTheillegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result ;
    // 判断长度大于8位后再接着判断是否同时包含数字和字母
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    return result;
}
/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+(NSString *)reviseString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

//判断银行卡是否正确
+ (BOOL) checkCardNo:(NSString*) cardNo{
    if (cardNo.length>0&&(cardNo.length==16||cardNo.length==19)) {
        
        int oddsum = 0;     //奇数求和
        int evensum = 0;    //偶数求和
        int allsum = 0;
        int cardNoLength = (int)[cardNo length];
        int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
        
        cardNo = [cardNo substringToIndex:cardNoLength - 1];
        for (int i = cardNoLength -1 ; i>=1;i--) {
            NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
            int tmpVal = [tmpString intValue];
            if (cardNoLength % 2 ==1 ) {
                if((i % 2) == 0){
                    tmpVal *= 2;
                    if(tmpVal>=10)
                        tmpVal -= 9;
                    evensum += tmpVal;
                }else{
                    oddsum += tmpVal;
                }
            }else{
                if((i % 2) == 1){
                    tmpVal *= 2;
                    if(tmpVal>=10)
                        tmpVal -= 9;
                    evensum += tmpVal;
                }else{
                    oddsum += tmpVal;
                }
            }
        }
        
        allsum = oddsum + evensum;
        allsum += lastNum;
        if((allsum % 10) == 0)
            return YES;
        else
            return NO;
    }
    else{
        
        return NO;
    }
    
}

+ (void)setContentInsetAdjustmentBehaviorNever4ScrollView:(UIScrollView *)scrollView {
    //判断系统版本 iOS11执行
#ifdef __IPHONE_11_0
    if ([scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        if ([scrollView isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)scrollView;
            
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
        }
    }
#endif
}

/**
 json解析 统一将取得的字段转换为string
 */
+(NSString *)toStringWithJsonValue:(id)value{
    NSString *str;
    if ([value isKindOfClass:[NSString class]])
    {
        str =value;
    }
    else if ([value isKindOfClass:[NSNumber class]])
    {
        str =[value stringValue];
    }
    else if ([value isKindOfClass:[NSNull class]])
    {
        str = @"";
    }
    else
    {
        str = @"";
    }
    
    return str;
}

#pragma mark=========获取当前类==========
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [Toolkit _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [Toolkit _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = image;
    
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat scaleFactor = 0.0;
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetSize.width / imageSize.width;
        CGFloat heightFactor = targetSize.height / imageSize.height;
        
        if (widthFactor < heightFactor){
            scaleFactor = heightFactor; // scale to fit height
        } else {
            scaleFactor = widthFactor; // scale to fit width
        }
    }
    scaleFactor = MIN(scaleFactor, 1.0);
    
    CGFloat targetWidth = imageSize.width* scaleFactor;
    CGFloat targetHeight = imageSize.height* scaleFactor;
    
    targetSize = CGSizeMake(floorf(targetWidth), floorf(targetHeight));
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"could not scale image");
        newImage = sourceImage;
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (void)gotoSignIn {
  
}

+ (UIImage *)imageWithBackGroundImage:(UIImage *)image contents:(NSArray *)contents {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, image.size.height * SCREEN_WIDTH / image.size.width);
    
    for (id content in contents) {
        
        if ([content isKindOfClass:[UIView class]]) {
            
            [imageView addSubview:content];
            
        } else if ([content isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = content;
            if (dict.count > 0) {
                
                NSString *key = [dict allKeys][0];
                CGRect frame = CGRectFromString(key);
                
                UIView *view;
                
                id theObject = [dict allValues][0];
                if ([theObject isKindOfClass:[UIImage class]]) {
                    
                    view = [[UIImageView alloc] initWithImage:theObject];
                    
                    [Toolkit addCornerRadius:3.0 toView:view];
                    
                } else if ([theObject isKindOfClass:[NSAttributedString class]]) {
                    
                    UILabel *label = [[UILabel alloc] initWithFrame:frame];
                    label.backgroundColor = [UIColor clearColor];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.adjustsFontSizeToFitWidth = YES;
                    label.attributedText = theObject;
                    
                    view = label;
                    
                }
                
                view.frame = frame;
                [imageView addSubview:view];
                
            }
            
        }
    }
    
    return [Toolkit zh_CaptureView:imageView];
}

+ (UIImage *)zh_CaptureView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (void)addCornerRadius:(float)cornerRadius toView:(UIView *)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

/**
 *  @brief  url query转成NSDictionary
 *
 *  @return NSDictionary
 */
+ (NSMutableDictionary *)dictionaryFromURLString:(NSString *)urlString {
    NSArray *pairs = [urlString componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *val = [[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [params setObject:val forKey:[kv objectAtIndex:0]];
        }
    }
    return params;
}


@end

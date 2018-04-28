//
//  Mall_APIClient.m
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/8.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "Mall_APIClient.h"
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access
#import <CommonCrypto/CommonCryptor.h>

#import "NetworkResponseUtility.h"

#define kSecretCode @"(#XC621#@@^!uh%)vuZGWGQ5s)dA0KK8"
@implementation Mall_APIClient


+ (Mall_APIClient *)sharedJsonClient {
    static Mall_APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Mall_APIClient alloc] initWithBaseURL:[NSURL URLWithString:kNetPath_Code_Base]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.requestSerializer.timeoutInterval=15.0f;
    
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(id data, NSError *error))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:NetworkMethod autoShowError:YES andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    //log请求数据
    NSMutableDictionary* param_token=[self toParams:params];
    DebugLog(@"\n===========request===========\n%@:\n%@", aPath, param_token);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    //发起请求
    switch (NetworkMethod) {
        case Get:{
            [self GET:aPath parameters:param_token success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                
                responseObject = [self handleResponse:responseObject autoShowError:autoShowError];
                block([NetworkResponseUtility removeNULL_Dictionary:responseObject], nil);

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                !autoShowError || [self showError:error];
                block(nil, error);
            }];
            break;}
        case Post:{
            [self POST:aPath parameters:param_token success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                
                responseObject = [self handleResponse:responseObject autoShowError:autoShowError];
                block([NetworkResponseUtility removeNULL_Dictionary:responseObject], nil);

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                !autoShowError || [self showError:error];
                block(nil, error);
            }];
            break;}
        case Put:{
            [self PUT:aPath parameters:param_token success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                
                responseObject = [self handleResponse:responseObject autoShowError:autoShowError];
                block([NetworkResponseUtility removeNULL_Dictionary:responseObject], nil);

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                !autoShowError || [self showError:error];
                block(nil, error);
            }];
            break;}
        case Delete:{
            [self DELETE:aPath parameters:param_token success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                
                responseObject = [self handleResponse:responseObject autoShowError:autoShowError];
                block([NetworkResponseUtility removeNULL_Dictionary:responseObject], nil);

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                !autoShowError || [self showError:error];
                block(nil, error);
            }];}
        default:
            break;
    }
    
}

-(void)requestJsonDataWithPath:(NSString *)aPath file:(NSDictionary *)file withParams:(NSDictionary *)params withMethodType:(int)NetworkMethod andBlock:(void (^)(id, NSError *))block{
    //log请求数据
    DebugLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // Data
    NSData *data;
    NSString *name, *fileName;
    
    if (file) {
        UIImage *image = file[@"image"];
        
        // 缩小到最大 800x800
        //        image = [image scaledToMaxSize:CGSizeMake(500, 500)];
        
        // 压缩
        data = UIImageJPEGRepresentation(image, 1.0);
        if ((float)data.length/1024 > 1000) {
            data = UIImageJPEGRepresentation(image, 1024*1000.0/(float)data.length);
        }
        
        name = file[@"name"];
        fileName = file[@"fileName"];
    }
    
    switch (NetworkMethod) {
        case Post:{
            
            AFHTTPRequestOperation *operation = [self POST:aPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                if (file) {
                    [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
                }
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                
                responseObject = [self handleResponse:responseObject];
                block([NetworkResponseUtility removeNULL_Dictionary:responseObject], nil);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                [self showError:error];
                block(nil, error);
            }];
            [operation start];
            
            break;
        }
        default:
            break;
    }
}

- (void)reportIllegalContentWithType:(IllegalContentType)type
                          withParams:(NSDictionary*)params{
    NSString *aPath;
    switch (type) {
        case IllegalContentTypeTweet:
            aPath = @"/api/inform/tweet";
            break;
        case IllegalContentTypeTopic:
            aPath = @"/api/inform/topic";
            break;
        case IllegalContentTypeProject:
            aPath = @"/api/inform/project";
            break;
        case IllegalContentTypeWebsite:
            aPath = @"/api/inform/website";
            break;
        default:
            aPath = @"/api/inform/tweet";
            break;
    }
    DebugLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    [self POST:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
    }];
}

- (void)uploadImage:(UIImage *)image path:(NSString *)path name:(NSString *)name
       successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
       failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
      progerssBlock:(void (^)(CGFloat progressValue))progress{
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if ((float)data.length/1024 > 1000) {
        data = UIImageJPEGRepresentation(image, 1024*1000.0/(float)data.length);
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", @"stack", str];
    DebugLog(@"\nuploadImageSize\n%@ : %.0f", fileName, (float)data.length/1024);
    
    AFHTTPRequestOperation *operation = [self POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        
        responseObject = [self handleResponse:responseObject];
        if (success) {
            success(operation, responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"Error: %@ ***** %@", operation.responseString, error);
        if (failure) {
            failure(operation, error);
        }
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progressValue = (float)totalBytesWritten/(float)totalBytesExpectedToWrite;
        if (progress) {
            progress(progressValue);
        }
    }];
    [operation start];
}

#pragma mark - 生成请求参数

/**
 *  在manager中添加请求参数和service生成param字典，在此处添加timestamp、deviceid和token
 *
 *  @param params 参数列表
 *
 *  @return 添加了deviceid、timestamp和token
 */
-(NSMutableDictionary*)toParams:(NSDictionary*)params{


    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *  senddate1=[NSDate dateWithTimeIntervalSinceNow:20] ;
    NSString *  timestamp=[dateformatter stringFromDate:senddate];
    NSString *  timestamp1=[dateformatter stringFromDate:senddate1];
    NSString* deviceid ;
    if(get_sp(kDeviceID)){
        // 存在标识码时取出deviceid
        deviceid=get_sp(kDeviceID);
    }else{
        //不存在是生成一个存储并赋值
        deviceid=[NSString stringWithFormat:@"%@-%@",[[[self md5:timestamp1] stringByReplacingCharactersInRange:NSMakeRange(1, 8) withString:@""] uppercaseString],[[self md5:timestamp] stringByReplacingCharactersInRange:NSMakeRange(1, 6) withString:@""]];
        set_sp(deviceid, kDeviceID);
    }
    
    NSMutableDictionary*param=    [params mutableCopy];
    [param setObject:timestamp forKey:@"timestamp"];
    [param setObject:deviceid forKey:@"touchid"];

    NSString* version=[NSString stringWithFormat:@"ios-%@",[Toolkit getCurrentAppVersion]];
    [param setObject:version forKey:@"version"];
//    [param setObject:@"enterprise" forKey:@"ios-mark"];//此标示代表是用户端企业版
    [param setObject:(IsEnterprise == 1 ? @"enterprise" : @"appstore") forKey:@"ios-mark"];//此标示代表是用户端企业版
    //!!!:设置config_test 为1，使用测试数据库,注释掉一下语句，连接正式数据库
    [param setObject:@"1" forKey:@"config_test"];
    
  
    
    NSArray* keys=    [param allKeys];
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *result = [keys sortedArrayUsingComparator:sort];
    
    //新的token生成逻辑
    int num=[[timestamp substringWithRange:NSMakeRange(timestamp.length-1, 1)] intValue]+5;
    int i=2;
    NSMutableString* str=[NSMutableString string];
    for (NSString* key in result) {
        NSString* value=[param objectForKey:key];
        int len=i*2;
        if ((num+len)>kSecretCode.length) {
            len=(int)kSecretCode.length-num;
        }
        if (i%2==1) {
            NSString*str_md5=[NSString stringWithFormat:@"%@%@%@",value,key,[kSecretCode substringWithRange:NSMakeRange(num, len)]];
            [str appendString:[self md5:str_md5]];
        }else{
            NSString* str_base64=[NSString stringWithFormat:@"%@%d%@",value,i,[kSecretCode  substringWithRange:NSMakeRange(num, len)]];
            [str appendString:[self base64StringFromText:str_base64]];
        }
        i++;
    }
    [param setObject:[self md5:str] forKey:@"token"];
    
    return param;
}

- (NSString *)md5:(NSString *)str
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

/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
- (NSString *)base64StringFromText:(NSString *)text{
    // Create NSData object
    NSData *nsdata = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    return base64Encoded;
}

#pragma mark - mock测试请求接口
- (void)requestJsonDataWithPath:(NSString *)url
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{

    [self POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DebugLog(@"\n===========response===========\n%@:\n%@", url, responseObject);
        
        responseObject = [self handleResponse:responseObject];
        if (block) {
            block([NetworkResponseUtility removeNULL_Dictionary:responseObject], nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DebugLog(@"\n===========response===========\n%@:\n%@", url, error);
        !autoShowError || [self showError:error];
        block(nil, error);
    }];
    
}


@end

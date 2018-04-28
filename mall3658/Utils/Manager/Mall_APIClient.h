//
//  Mall_APIClient.h
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/8.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

typedef NS_ENUM(NSInteger, IllegalContentType) {
    IllegalContentTypeTweet = 0,
    IllegalContentTypeTopic,
    IllegalContentTypeProject,
    IllegalContentTypeWebsite
};

@interface Mall_APIClient : AFHTTPRequestOperationManager

+ (id)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                           file:(NSDictionary *)file
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(id data, NSError *error))block;


- (void)reportIllegalContentWithType:(IllegalContentType)type
                          withParams:(NSDictionary*)params;

- (void)uploadImage:(UIImage *)image path:(NSString *)path name:(NSString *)name
       successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
       failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
      progerssBlock:(void (^)(CGFloat progressValue))progress;

-(NSMutableDictionary*)toParams:(NSDictionary*)params;
- (NSString *)md5:(NSString *)str;


#pragma mark - eoapi测试请求接口
- (void)requestJsonDataWithPath:(NSString *)url
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

@end

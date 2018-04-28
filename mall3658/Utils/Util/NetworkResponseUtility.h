//
//  NetworkResponseUtility.h
//  Business
//
//  Created by buyhoo on 2017/8/24.
//  Copyright © 2017年 Haier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkResponseUtility : NSObject

+ (NSMutableDictionary *)removeNULL_Dictionary:(NSDictionary *)dictionary;

+ (NSMutableArray *)removeNULL_Array:(NSArray *)array;

+ (id)responseObject:(id)responseObject;

+ (id)responseObject:(id)responseObject showMessage:(BOOL)showMessage;

@end

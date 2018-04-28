//
//  NetworkResponseUtility.m
//  Business
//
//  Created by buyhoo on 2017/8/24.
//  Copyright © 2017年 Haier. All rights reserved.
//

#import "NetworkResponseUtility.h"

@implementation NetworkResponseUtility

+ (NSMutableDictionary *)removeNULL_Dictionary:(NSDictionary *)dictionary {
    
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSArray *keyArr = [dictionary allKeys];
    
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    
    for (int i = 0; i < keyArr.count; i ++) {
        
        id obj = [dictionary objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        if (obj) {
            resDic[keyArr[i]] = obj;
        }
    }
    
    return resDic;
}

+ (NSMutableArray *)removeNULL_Array:(NSArray *)array {
    
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < array.count; i ++) {
        
        id obj = array[i];
        
        obj = [self changeType:obj];
        
        if (obj) {
            [resArr addObject:obj];
        }
    }
    
    return resArr;
}

+(id) changeType:(id)myObj {
    
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self removeNULL_Dictionary:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self removeNULL_Array:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return myObj;
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    else
    {
        return myObj;
    }
}

+ (id)responseObject:(id)responseObject {
    
    return [self responseObject:responseObject showMessage:YES];
}

+ (id)responseObject:(id)responseObject showMessage:(BOOL)showMessage {
    
    NSString *message;
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *dictionary = [self removeNULL_Dictionary:responseObject];
        
        NSInteger status = [dictionary[@"status"] integerValue];
        
        if (status == 1) {
            
            return dictionary[@"data"] ? : responseObject;
            
        } else {
            
            message = dictionary[@"msg"] ? : @"网络请求失败";
            
        }
        
    } else {
        message = @"网络请求失败";
    }
    
    if (showMessage && message) {
        [SVProgressHUD showErrorWithStatus:message];
    }
    
    return nil;
}

@end

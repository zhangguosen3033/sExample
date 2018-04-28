//
//  Mall_APIManager.m
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/8.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "Mall_APIManager.h"
#import "Mall_APIClient.h"
@implementation Mall_APIManager
+ (instancetype)sharedManager {
    static Mall_APIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

#pragma mark - eoapi测试请求接口
-(void)request_eoapi:(NSString *)url andBlock:(void(^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:url autoShowError:YES andBlock:^(id data, NSError *error) {
       
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
        //TODO:进行数据和逻辑处理，model和viewmodel的处理
        block(data, nil);
        }else{
        block(nil, error);
        }
        
        
    }];

}

-(void)baseRequest_CustomeParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


-(BOOL)isNetworkReachable{
    NSURL *baseURL = [NSURL URLWithString:@"http://www.3658mall.com/"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                [operationQueue setSuspended:NO];
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
                break;
            default:
                
                [operationQueue setSuspended:YES];
                
                break;
                
        }
        
    }];
    
    //开始监控

    [manager.reachabilityManager startMonitoring];
//
//return     [[AFNetworkReachabilityManager sharedManager] isReachable];

    return manager.reachabilityManager.isReachable;

}

#pragma mark 接口3.1.1首页主广告接口
- (void)request_IndexBannerWithBlock:(void (^)(id data, NSError *error))block{
    //[MobClick event:kUmeng_Event_Request label:@"登录"]; //友盟分析
    
    NSDictionary* dict=@{@"service":@"Ad.AdList",@"ad_type":@"index"};
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO: 进行数据和逻辑处理，返回处理过的model数据
            //block回调进行处理,返回使用MJExtension进行处理的model,在vc中判断是否为空

            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.1.2 百度广告联盟 Ad.BaiduAd
-(void)request_Ad_BaiduAdWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.1.3 活动的视频广告 Ad.VideoAd
-(void)request_Ad_VideoAdWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.1.4 活动的商品广告
-(void)request_Ad_GoodsAdWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.3.1活动商品列表接口
-(void)request_TaskListWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO: 进行登录处理
            //block回调进行登录处理,返回使用MJExtension进行处理的model,在vc中判断是否为空
            //            id model;
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}



#pragma mark 接口3.3.2 活动详情接口
-(void)request_TaskDetailWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.3.3 领取活动接口
-(void)request_ReceiveTaskWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
#pragma mark 接口3.4.1文章列表接口
-(void)request_ArticleListWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    NSMutableDictionary* dict;
    
    if (params==nil) {
        dict=        [NSMutableDictionary dictionary];
    }else{
        dict=[params mutableCopy];
    }
    [dict setObject:@"Article.AList" forKey:@"service"];
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.4.2公告列表
-(void)request_Article_IndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
#pragma mark 接口3.5.1 活动评论列表接口
-(void)request_TaskComment_IndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.5.2 添加活动评论接口
-(void)request_TaskComment_AddWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.5.3 评论总数
-(void)request_TaskComment_CountNumWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.1用户登录接口
-(void)request_LoginWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.2用户登出接口
-(void)request_LogoutWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            
            block(resultData, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口 3.6.3 获取手机验证码接口
-(void)request_MCodeWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.4 用户注册接口
-(void)request_RegisterWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.5 获取用户基本信息

-(void)request_UserInfoWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.6 忘记密码
-(void)request_User_ForgetWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.7 是否实名认证和设置支付密码 
-(void)request_UserCenter_CheckRealnameWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    [dict setObject:@"UserCenter.CheckRealname" forKey:@"service"];
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:dict withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.8 是否可以修改用户名和修改用户名
-(void)request_UserCenter_EditInfoWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.8_2  上传用户头像
- (void)request_UserCenter_UploadHeadimgWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.9 修改用户资料

-(void)request_UserCenter_EditUserinfoWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.6.11 验证支付密码 

-(void)request_UserCenter_AuthPayPasswdWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


#pragma mark 接口3.7.1 个人资产汇总
-(void)request_MoneyIndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.7.2 个人资产明细
-(void)request_MoneyDetailWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.8.1 银行卡列表
-(void)request_Bank_IndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.8.2 银行卡实名认证
-(void)request_Bank_RealNameAuthWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.8.3 添加银行卡
-(void)request_Bank_AddWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.8.4 银行卡信息
-(void)request_Bank_CardInfoWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.8.5 银行卡是否已添加 Bank.CardIsExist

-(void)request_Bank_CardIsExistWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.8.6 支持银行列表
-(void)request_Bank_SupportBankWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 接口3.8.7 设置默认银行卡

-(void)request_Bank_SetDefaultWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.8.7 删除银行卡 Bank.Delete

-(void)request_Bank_DeleteWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.9.1 提现
-(void)request_Takecash_TakeWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.9.2 银行卡转账
-(void)request_Takecash_TransferWithParams:(NSDictionary *)params andBloc:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.9.3 充值
-(void)request_Takecash_RechargeWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.9.4 确认充值支付
-(void)request_Takecash_PaymentWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


#pragma mark 3.10.1 活动列表
-(void)request_Usertask_IndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.10.2 活动详情
-(void)request_UserTask_DetailWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.10.3 开始活动
-(void)request_Usertask_StartWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.10.4 完成活动
-(void)request_Usertask_CompleteWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.10.5 结束活动
-(void)request_Usertask_EndWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.10.6 是否可以展期
-(void)request_Usertask_IsRenewalWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.10.7 展期活动
-(void)request_Usertask_RenewalWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.11.1 后台模块配置参数列表
-(void)request_Config_IndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.12.1 我的邀请信息
-(void)request_Team_SpreadWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.12.2 推广列表
-(void)request_Team_AffiliateWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.13.1  修改登录密码
-(void)request_Setting_SetPasswdWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.13.2  设置或修改支付密码
-(void)request_Setting_SetPaypasswdWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];                             
}

#pragma mark 3.13.3 更换手机号

-(void)request_Setting_SetMobileWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.14.1 协议内容
-(void)request_Agreement_DetailWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.15.1 清除api中商城参数文件缓存
-(void)request_Cache_ShopConfigClearWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.16.1 分享信息 
-(void)request_Share_IndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.16.2 我的邀请-分享信息
-(void)request_Share_SpreadWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
#pragma mark 3.17.1 检测是否有最新版本
-(void)request_Check_Version_Update:(NSDictionary *)params andBlock:(void (^)(id data, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}

#pragma mark 3.18.1 红筹列表专场

-(void)request_Chips_IndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
#pragma mark 3.18.2 红筹详情

-(void)request_Chips_DetailWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
#pragma mark 3.18.3 领取红筹

-(void)request_Chips_GetChipsWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
-(void)request_Chips_GetQaWithParams:(NSDictionary*) params andBlock:(void(^)(id data,NSError*error))block{

    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
#pragma mark 3.19.1 我的红筹列表

-(void)request_Userchips_IndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
#pragma mark 3.19.2 我的红筹详细

-(void)request_Userchips_DetailWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.19.3 我的红筹结束

-(void)request_Userchips_EndWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.19.4 我的红筹展期

-(void)request_Userchips_RenewalWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


#pragma mark 3.20.1 红筹评论列表

-(void)request_ChipsComment_IndexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.20.2 评论总数

-(void)request_ChipsComment_CountNumWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.20.3 评论添加接口

-(void)request_ChipsComment_AddWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.21.1开始签到

-(void)request_Sign_StartSignWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.21.2 完成签到

-(void)request_Sign_CompleteSignWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark 3.22.1 我的代金券列表

-(void)request_UserVoucher_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}


#pragma mark 3.22.2 选取代金券列表

-(void) request_UserVoucher_SelectWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{

    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}

#pragma mark - 商城模块接口

#pragma mark *  3.23 首页专柜特区 (Category.cateGoriesse)
-(void)request_Category_cateGoriesseWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark
-(void)request_Index_everyGroupWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark  *  3.25 首页猜您喜欢 (Index.bestGoods)
-(void)request_Index_bestGoodsWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark  *  3.26 商品详情 (Goods.getGoodInfo)
-(void)request_Goods_getGoodInfoWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.27 商品属性 (Goods.getGoodsProperties)
-(void)request_Goods_getGoodsPropertiesWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.28 商品评论 (Goods.getComment)
-(void)request_Goods_getCommentWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.29 商品评论 (Goods.getCommentNum)
-(void)request_Goods_getCommentNumWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.30 专柜商品 (Category.getCateGoods)
-(void)request_Category_getCateGoodsWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.31 商家信息 (Suppliers.getInfo)
-(void)request_Suppliers_getInfoWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


#pragma mark *  3.32 商家信息 (Goods.getPrice)
-(void)request_Goods_getPriceWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.33 加入购物车 (Flow.add_to_cartNew)
-(void)request_Flow__add_to_cartWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.34 查看购物车 (Flow.index)
-(void)request_Flow_indexWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.34 广告 (Ads.getAds)
-(void)request_Ads_getAdsWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.35 删除购物车商品 (Flow.drop_goods)
-(void)request_Flow__drop_goodsWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.36 收货地址列表 (Address.getList)
-(void)request_Address_getListWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.37 省级市 (Address.regions)
-(void)request_Address_regionsWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark *  3.38 修改/添加收货地址 (Address.act_edit_address)
-(void)request_Address__act_edit_addressWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark  *  3.39 默认收货地址 (Address.def)
-(void)request_Address_defWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.40 删除收货地址（Address.del）
-(void)request_Address_delWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.41 购物车提交 (Flow.checkout)
-(void)request_Flow_checkoutWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
#pragma mark * 3.42 订单支付 (Flow.done)
-(void)request_Flow_doneWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.43 选择红包./快递 价格变动 (Flow.change)
-(void)request_Flow_changeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.44 搜索 (Search.lists)
-(void)request_Search_listsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.45 个人中心 (Member.index)
-(void)request_Member_indexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.46 我的收藏 (Collection.lists)
-(void)request_Collection_listsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.47 加入收藏 (Collection.collect)
-(void)request_Collection_collectWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.48 删除收藏 (Collection.delete)
-(void)request_Collection_deleteWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.49 我的订单 (Member.orderList)
-(void)request_Member_orderListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark * 3.50 确认收货 (Member.affirmReceived)
-(void)request_Member_affirmReceivedWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.51 买家评论(Member.comment)
-(void)request_Member_commentWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.52 退/换货订单列表 (Order.returnList)
-(void)request_Order_returnListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.53 取消退/换货 (Order.cancelReturn)
-(void)request_Order_cancelReturnWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.54 申请退/换货列表 (Order.applyReturn)
-(void)request_Order_applyReturnWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.55 退/换货提交 (Order.submitReturn)
-(void)request_Order_submitReturnWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.56 我的红包 (Member.onBonus)
-(void)request_Member_onBonusWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.57 物流跟踪 (Kuaidiapi.getLogistics)
-(void)request_Kuaidiapi_getLogisticsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.58 订单详情 (Order.orderDetail)
-(void)request_Order_orderDetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.59 分类预览页 (Category.getCates)
-(void)request_Category_getCatesWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.59 提醒卖家发货 (Order.deliver)
-(void)request_Order_deliverWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.60 公告通知 (Article.Index)
-(void)request_Article_IndexParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.61 我的投诉列表 (Order.complaintsList)
-(void)request_Order_complaintsListParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.62 投诉提交 (Order.addComplaints)
-(void)request_Order_addComplaintsParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.63 取消订单 (Order.cancelOrder)
-(void)request_Order_cancelOrderParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.64 订单中可申请退货的商品 (Order.goodsOrder)
-(void)request_Order_goodsOrderParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.65 单个商品立即支付 (Buycart.done)
-(void)request_Buycart_doneParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.66 退货订单详情 (Order.returnDetail)
-(void)request_Order_returnDetailParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.67 添加寄回退货信息 (Order.ReturnAddressNew)
-(void)request_Order_returnAddressParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.68 专柜特区 (Category.cateGoriesList)
-(void)request_Category_cateGoriesListParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
   
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.69 退换货注意事项 (Order.returnContent)
-(void)request_Order_returnContentParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
   
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.70 选择支付种类 (Order.orderPay)
-(void)request_Order_orderPayParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//3.71签到人数（Index.signNum）
-(void)request_Index_signNumWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

// 3.72 急验验证请求地址 (GeeTest.geeTestUrl)
-(void)request_GeeTest_geeTestUrlWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        } 
    }];
}

// 3.73 手机号码是否注册(User.checkPhone)

-(void)request_User_checkPhoneWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

// 3.74 获取支持的银行(Bank.cardList)
-(void)request_Bank_cardListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

// 3.75 推荐奖励(UserRecommend.index)
-(void)request_UserRecommend_indexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

// 3.76 积分转红金宝(UserRecommend.integral)
-(void)request_UserRecommend_integralWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

// 3.77 积分转红金宝(UserRecommend.integralMoney)
-(void)request_UserRecommend_integralMoneyWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

// 3.78 订单列表（白拿）(GoodsOrder.OrderList)
-(void)GoodsOrder_OrderListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{

    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}
// 3.79 立即购买选择页面（白拿）(FreeFlow.FreeCheckout)
-(void)FreeFlow_FreeCheckoutWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{

    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}
//3.80 白拿支付（白拿）(FreeFlow.FreeDone)
-(void)FreeFlow_FreeDoneWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{

    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
//3.81 白拿支付（白拿）(FreeFlow.FreeDone)
-(void)GoodsOrder_AdvanceGetWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{


    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


//************************************************************************************

#pragma mark  version 3.50接口


//   #13 接口：Scan.GetFree

-(void)request_Scan_GetFreeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//  #14 接口：Scan.ScanCodeStart
-(void)request_Scan_ScanCodeStartWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
#pragma mark --- version 3.50 接口
//****************************************************************************************************************************************************
/**
 *    version 3.50 接口 (来源：http://tsiteapi.3658mall.com/Public/suppdemo/)
 */

/**
 *   #1
 */

/**
 *   #2
 */

/**
 *   #3
 */


/**
 *   #4 订单列表(weiyb) (GoodsOrder.OrderList)
 */
- (void)request_GoodsOrder_OrderListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {

    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


////  #14 接口：Scan.ScanCodeStart
//-(void)request_Scan_ScanCodeStartWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
//}
/**
 *   #6 获取白拿规则(yanh) Line.GetFreeRules
 */
-(void)request_Line_GetFreeRulesWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];



}

/**
 *   #8 获取订单(yanh) Line.GetOrders
 */
- (void)request_Line_GetOrdersWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {

    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


/**
 *   #10 提交订单(yanh) line.lineOrder
 */
-(void)request_line_lineOrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}

/**
 *   #15 二维码扫描(yanh) Scan.SelectFreeCode
 */
-(void)request_Scan_SelectFreeCodeWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];



}




/**
 *   #16 获取订单(yanh) Line.GetOrder
 **/
-(void)request_Line_GetOrderWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *   #17 提前取消白拿订单(yanh) Line.OverOrder
 **/
-(void)request_Line_OverOrderWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *   #18 慧赚宝首页(weiyb) UserHzb.Index
 **/
- (void)request_UserHzb_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
    
}

/**
 *   #19 转入慧赚宝(weiyb) UserHzb.HzbIn
 **/
-(void)request_UserHzb_HzbInWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
    
}

/**
 *   #20  慧赚宝明细(weiyb) UserHzb.HzbDesc
 *
 */
- (void)request_UserHzb_HzbDescWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *   #21 慧赚宝转入转出明细(weiyb) UserHzb.HzbMoneyDesc
 *
 */
- (void)request_UserHzb_HzbMoneyDescWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
        
    }];
    
}


/**
 *   #20 转出慧赚宝(weiyb) UserHzb.HzbOut
 **/
-(void)request_UserHzb_HzbOutWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}

#pragma mark --- version 商户端特有接口
/**
 *   #1 商家首页接口：UserSupp.Index
 **/
-(void)request_UserSupp_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
    
}

/**
 *   #2 商家资金明细接口：UserSupp.MoneyDesc
 **/
-(void)request_UserSupp_MoneyDescWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
        [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
            id resultData = [data valueForKeyPath:@"data"];
            if (resultData) {
                //TODO:进行数据和逻辑处理，model和viewmodel的处理
                block(data, nil);
            }else{
                block(nil, error);
            }
        }];
        
    }


/**
 *  #18  提交提现(sentangle)
 */
-(void)request_SuppTakecash_TakeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}


/**
 *    #19 提现信息(sentangle)
 */
-(void)request_SuppTakecash_TakeInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
        
        
        [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
            id resultData = [data valueForKeyPath:@"data"];
            if (resultData) {
                //TODO:进行数据和逻辑处理，model和viewmodel的处理
                block(data, nil);
            }else{
                block(nil, error);
            }
            
        }];    
        
    }

/**
 *    #127 购物车商品数量修改(weiyb) Upflow.SetgoodsNum
 */
-(void)request_Upflow_SetgoodsNumWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
        
    }];
}

/**
 *   #146 会员交易大厅委托记录(weiyb) UserJY.Order
 **/
-(void)request_UserJY_OrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *    #147 交易密码(weiyb) UserJY.SetTransPasswd
 */
-(void)request_UserJY_SetTransPasswdWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
        
    }];
}

/**
 *   #148 会员交易大厅成交记录(weiyb) UserJY.Userorder
 **/
-(void)request_UserJY_UserorderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}

/**
 *   #150 取消委托(weiyb) 接口：UserJY.Stop
 **/
-(void)request_UserJY_StopWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}

/**
 *   #149  交易大厅 HJB 买入卖出(weiyb) UserJY.Add
 **/
-(void)request_UserJY_AddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
    
}

/**
 *   #150  会员交易大厅个人中心(weiyb) UserJY.Index
 **/
-(void)request_UserJY_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *   #151 交易大厅首页(weiyb) 接口：JY.Index
 */
-(void)request_JY_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *   #152 交易大厅首页记录(weiyb) 接口：JY.Order
 */
-(void)request_JY_OrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *   #153 是否设置交易密码(weiyb) 接口：UserJY.Issetpsd
 */
-(void)request_UserJY_IssetpsdWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #154 是否设置交易密码(weiyb) UserJY.Issetpsd
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	Category.Newcatlist	 string	接口调用api名称
 *  @param  2	POST	是	cat_id	     int	 0=>所有1级分类,其他是各自分类
 */
-(void)request_Category_NewcatlistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *   #16 开户支行地区关键字(weiyb) 接口：Bank.BankSearch
 */
-(void)request_Bank_BankSearchWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
    
    
}



/**
 *  #155 是否登陆接口(weiyb) Bank.Relogin
 */
-(void)request_Bank_ReloginWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #156 文章分享列表(weiyb) Share.Lists
 */
-(void)request_Share_ListsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #157 签到完成(weiyb) SignNew.CompleteSign
 */
-(void)request_SignNew_CompleteSignWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


#pragma mark  #158 短提示获取(weiyb) GetCom.Index

-(void)request_GetCom_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
    
}

/**
 *  #159 红金宝转余额前置条件(weiyb) UserJYM.Check
 */
-(void)request_UserJYM_CheckWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #160 红金宝转余额(weiyb) UserJYM.JymSub
 */
-(void)request_UserJYM_JymSubWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #161 完成分享(weiyb) DayShare.CompleteShare
 */
-(void)request_DayShare_CompleteShareWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #162 每日分享链接(weiyb) DayShare.Lists
 */
-(void)request_DayShare_ListsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #163 体验金列表(PPOGG) UserHzb.TyjList
 */
-(void)request_UserHzb_TyjListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #164 商品购物车数量(PPOGG) Flow.CartAllNum
 */
-(void)request_Flow_CartAllNumWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//********************************************************************************
//********************************************************************************
#pragma mark - Version 4.0 聊天接口
/**
 *  #159  Rongyun.Gettaken
 */
-(void)request_Rongyun_GettakenWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #160 获取好友列表(ppogg) UserRongyun.Friendslist
 */
-(void)request_UserRongyun_FriendslistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #161 搜索好友(ppogg) UserRongyun.Searchfriends
 */
-(void)request_UserRongyun_SearchfriendsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #162 添加好友(ppogg) UserRongyun.Friendsadd
 */
-(void)request_UserRongyun_FriendsaddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #163 好友请求处理(ppogg) UserRongyun.FriendsaddUP
 */
-(void)request_UserRongyun_FriendsaddUPWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #164 删除好友(ppogg) UserRongyun.FriendsDel
 */
-(void)request_UserRongyun_FriendsDelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #165 黑名单列表(ppogg) UserRongyun.Frindsblacklist
 */
-(void)request_UserRongyun_FrindsblacklistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #166  加入黑名单(ppogg) UserRongyun.FrindsblacklistAdd
 */
-(void)request_UserRongyun_FrindsblacklistAddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #167  移出黑名单(ppogg) UserRongyun.FrindsblacklistDel
 */
-(void)request_UserRongyun_FrindsblacklistDelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #168  好友关系请求记录(ppogg) UserRongyun.Frindssavelists
 */
-(void)request_UserRongyun_FrindssavelistsWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #169  会员信息(ppogg) UserRongyun.UserInfo
 */
-(void)request_UserRongyun_UserInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #170  获取群列表(ppogg) UserRongyun.Grouplist
 */
-(void)request_UserRongyun_GrouplistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #171  搜索群(ppogg) UserRongyun.Searchgroup
 */
-(void)request_UserRongyun_SearchgroupWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #172  群详情(ppogg) UserRongyun.GroupDesc
 */
-(void)request_UserRongyun_GroupDescWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #173  创建群(ppogg) UserRongyun.GroupCreate
 */
-(void)request_UserRongyun_GroupCreateWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #174  退出群(ppogg) UserRongyun.GroupBack
 */
-(void)request_UserRongyun_GroupBackWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #175  解散群(ppogg)  UserRongyun.GroupDel
 */
-(void)request_UserRongyun_GroupDelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #176  解散群(ppogg)  UserRongyun.GroupAdd
 */
-(void)request_UserRongyun_GroupAddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #177  群主邀请入群(ppogg)  UserRongyun.GroupBossAddUser
 */
-(void)request_UserRongyun_GroupBossAddUserWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #178  群主修改群信息(ppogg)  UserRongyun.GroupBossUp
 */
-(void)request_UserRongyun_GroupBossUpWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 *  #179  群主同意入群(ppogg) UserRongyun.GroupBossAdd
 */
-(void)request_UserRongyun_GroupBossAddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #179  聊天室列表(ppogg) UserRongyun.ChatroomList
 */
-(void)request_UserRongyun_ChatroomListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #180  关联手机通讯录(ppogg) UserRongyun.RelationTel
 */
-(void)request_UserRongyun_RelationTelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

#pragma mark----------------生活缴费-------------------
/**
 *  #176 生活缴费订单(PPOGG) Elife.Elifelist
 */
-(void)request_Elife_ElifelistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #177 缴费订单删除(PPOGG) Elife.DelElife
 */
-(void)request_Elife_DelElifeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #178 生活缴费地址获取(PPOGG) Elife.Elifechange
 */
-(void)request_Elife_ElifechangeWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 *  #179 获取缴费类型(PPOGG) Elife.ElifechangeTC
 */
-(void)request_Elife_ElifechangeTCWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 *  #180 获取缴费单位(PPOGG) Elife.Elifechangecompany
 */
-(void)request_Elife_ElifechangecompanyWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 * #181 获取商品信息(PPOGG) Elife.Elifechangeinfo
 */
-(void)request_Elife_ElifechangeinfoWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 *   #182 验证帐号(PPOGG) Elife.Elifecheckuser
 */
-(void)request_Elife_ElifecheckuserWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *   #183 话费充值白拿白赚提前取出(PPOGG) ElifeRecharge.CancelRecharge
 */
-(void)request_ElifeRecharge_CancelRechargeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *   #184 手机充值订单删除(PPOGG) ElifeRecharge.Delrecharge
 */
-(void)request_ElifeRecharge_DelrechargeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *   #185 话费充值订单(PPOGG) ElifeRecharge.Rechargelist
 */
-(void)request_ElifeRecharge_RechargelistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #186 生活缴费水电煤确认付款(PPOGG) Elife.DoElife
 */
-(void)request_Elife_DoElifeWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #187 话费订单详情(PPOGG) ElifeRecharge.RechargeInfo
 */
-(void)request_ElifeRecharge_RechargeInfoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 * #188 生活和缴费套餐选择(PPOGG) Elife.ElifeConfirm
 */
-(void)request_Elife_ElifeConfirmWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 * #189 手机话费充值套餐选择(PPOGG) ElifeRecharge.Changetaocan
 */
-(void)request_ElifeRecharge_ChangetaocanWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 * #190 话费充值(PPOGG) ElifeRecharge.RechargeDo
 */
-(void)request_ElifeRecharge_RechargeDoWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 * #191 话费充值续费(PPOGG) ElifeRecharge.RechargeXufei
 */
-(void)request_ElifeRecharge_RechargeXufeiWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 *  #192 获取手机号码归属地(cais) ElifeRecharge.GetPhoneAttribution
 */

-(void)request_ElifeRecharge_GetPhoneAttributionWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #193 话费充值余额付款(PPOGG) ElifeRecharge.Elifeorderdo
 */
-(void)request_ElifeRecharge_ElifeorderdoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #194  生活缴费余额付款(PPOGG) Elife.Elifeorderdo
 */
-(void)request_Elife_ElifeorderdoWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #195  首页商品热卖、热评、新品(fjw) Index.HeatGoods
 */
-(void)request_Index_HeatGoodsWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}
/**
 *  #196  首页商品热卖、热评、新品列表(fjw)
 */
-(void)request_Index_HeatGoodsListWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}

/**
 * #197 任务中心任务列表(PPOGG) TaskConter.TaskConterIndex
 */
-(void)request_TaskConter_TaskConterIndexWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError * error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 *  #198 任务中心领取任务(PPOGG) TaskConter.GetTask
 */
-(void)request_TaskConter_GetTaskWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError * error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #199 任务中心领取奖励(PPOGG) TaskConter.GetMoney
 */
-(void)request_TaskConter_GetMoneyWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError * error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #200 任务中心会员中心转余额(PPOGG) TaskConter.ZhuanYue
 */
-(void)request_TaskConter_ZhuanYueWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #201 进度条领取奖励(PPOGG) TaskConter.JindutiaoJiangli
 */
-(void)request_TaskConter_JindutiaoJiangliWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #202 任务完成(PPOGG) TaskConter.TaskWancheng
 */
-(void)request_TaskConter_TaskWanchengWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #203 第一次注册登录APP弹窗(PPOGG) TaskConter.NewLogin
 *
 *  @param  序号	请求方式	必填	名称	类型	描述
 *  @param  1	GET	    是	TaskConter.NewLogin    string	接口调用api名称
 */
-(void)request_TaskConter_NewLoginWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *   #204 手动结束白拿订单(PPOGG)  GoodsOrder.OrderFinish
 **/
-(void)request_GoodsOrder_OrderFinishWithParams:(NSDictionary *)params andBlock:(void (^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
    
}

/**
 *  #144 领取注册红包(PPOGG) User.Zhucehongbao
 */
-(void)request_ZhucehongbaoWithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
    
}

/**
 *  #163 第三方登录注册(weiyb) User.OpenRegister
 */
-(void)request_User_OpenRegisterWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #164  第三方登录绑定(weiyb) UserOpen.Band
 */
-(void)request_UserOpen_BanddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #165 第三方绑定(weiyb) User.OpenBand
 */
-(void)request_User_OpenBandWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #166 第三方帐号解绑(weiyb) UserOpen.BandDel
 */
-(void)request_UserOpen_BandDelWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #167 查看第三方帐号绑定状态(weiyb) UserOpen_Index
 */
-(void)request_UserOpen_IndexWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
//********************************************************************************
//********************************************************************************
#pragma mark - Version 慧赚宝App1.0
/**
 *  #168 获取经营类目信息（zhangh） Suppliers.GetCategory
 */
-(void)request_Suppliers_GetCategoryWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #169 上传图片 UserCenter.UploadImage
 */
-(void)request_UserCenter_UploadImageWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
   
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #170 认证信息提交(zhangh) SuppTakecash.SupAuth
 */
-(void)request_SuppTakecash_SupAuthWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #171 验证是否是商家账户（zhangh） User.CheckSup
 */
-(void)request_User_CheckSupWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #172 获取订单(zhangh) FanXian.OrderList
 */
-(void)request_FanXian_OrderListWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #173 加速返现(zhangh) FanXian.AddSupOrder
 */
-(void)request_FanXian_AddSupOrderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #174 保证金转出(zhangh) FanXian.GetSupMoney
 */
-(void)request_FanXian_GetSupMoneyWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #175 新签到（zhangh) SignNew.NewSign
 */
-(void)request_SignNew_NewSignWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}


/**
 *  #176 请求添加银行卡（zhangh) XianFeng.Add
 */
-(void)request_XianFeng_AddWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #177 确认添加银行卡(zhangh) XianFeng.Add_bank_code
 */
-(void)request_XianFeng_Add_bank_codeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}

/**
 *  #178 先锋再次获取短信验证码(zhangh) XianFeng.Sms_code
 */
-(void)request_XianFeng_Sms_codeWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}

/**
 *  #179 摇钱树(zhangh) User_YxUrl
 */
-(void)request_User_YxUrlWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block{
    
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #180共享红包展示页面 Loophappy.Rulelist
 */
-(void)request_Loophappy_RulelistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];


}

/**
 *  #181 打开共享红包 Loophappy.Openred
 */
-(void)request_Loophappy_OpenredWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}
/**
 *  #182 检验购买资格 Loophappy.Checkgetred
 */
-(void)request_Loophappy_CheckgetredWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
    
}
/**
 *  #183 购买共享红包 Loophappy.Getred
 */
-(void)request_Loophappy_GetredWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}
/**
 *  #184 我的共享列表 Loophappy.Myred
 */
-(void)request_Loophappy_MyredWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}
/**
 *  #185 我的共享详情页 Loophappy.Myreddetail
 */
-(void)request_Loophappy_MyreddetailWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #186 生成确认支付页面接口(weiyb)   HzbShoping.DirectBtBy
 */
-(void)request_HzbShoping_DirectBtByWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #187 衣食住行删除订单 Lifefree.Delorder

 */
-(void)request_Lifefree_DelorderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}

/**
 *  #188 共享额度订单列表 Lifefree.Orderlist
  */
-(void)request_Lifefree_OrderlistWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}
/**
 *  #189 列表页更多订单链接 Lifefree.Moreorders
 */
-(void)request_Lifefree_MoreordersWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];

}
/**
 *  #190 结束订单 Lifefree.Endorder
 */
-(void)request_Lifefree_EndorderWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block
{
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #191    立即购买生成订单   HzbShoping.orderdone
 */
-(void)request_HzbShoping_orderdoneWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
/**
 *  #192    平台内资金支付   HzbShoping.Orderpay
 */
-(void)request_HzbShoping_OrderpayWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

/**
 *  #193    购物车商品(多个或者一个)提交   HzbShoping.Checkout
 */
-(void)request_HzbShoping_CheckoutWithParams:(NSDictionary*)params andBlock:(void(^)(id data,NSError* error))block {
    [[Mall_APIClient sharedJsonClient] requestJsonDataWithPath:kNetPath_Code_Task withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            //TODO:进行数据和逻辑处理，model和viewmodel的处理
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

@end


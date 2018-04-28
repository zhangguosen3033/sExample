//
//  AppDelegate.m
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/2.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "AppDelegate.h"

#import "UMSocial.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "Seller_HomeViewController.h"
#import "UMessage.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define _IPHONE80_ 80000

/** 融云功能取消，代码注释 **/
//#import "RCDTestMessage.h"
//#import "Mall_Custom_message.h"
//#import "RCDRCIMDataSource.h"
//#import "RCDHttpTool.h"
//#import "RCDataBaseManager.h"

#import <AMapFoundationKit/AMapFoundationKit.h>

#import <IQKeyboardManager.h>

@interface AppDelegate ()<UIAlertViewDelegate>

{
    BOOL lanuchVCShow;//该布尔值用来判断广告业作为跟视图，解决与推出验证手势的viewController的影响
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
//    [[PgyManager sharedPgyManager] setThemeColor:[Toolkit getColor:hex_red_color]];
//    [[PgyManager sharedPgyManager] startManagerWithAppId:@"0648f13684f95bb48d2983d302694156"];
    NSLog(@"%f",SCREEN_WIDTH);
    
    [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:kLoginCreatIndicator];
    
    self.kNewsSwitch=1;
    
    /**
     *  将区域数据存入数据库
     */
//    [MagicalRecord setupCoreDataStackWithStoreNamed:@"mydb.sqlite"];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"mydbNew.sqlite"];
    
    
    //高德地图配置
    [AMapServices sharedServices].apiKey = GDMapAppkey;

    /**
     界面相关配置
     
     */
    _tabBarViewCol = [[CustomTabBarViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
    
    //    self.window.rootViewController =_tabBarViewCol;
    //
    //    [self.window makeKeyAndVisible];
    //创建存储路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"first"];
  
    self.window.rootViewController=_tabBarViewCol;

    [self.window makeKeyAndVisible];
    
    
    /**
     *  初始化网络监听
     */
    [[Mall_APIManager sharedManager] isNetworkReachable];
    
    //!!!: 推送相关设置
    //set AppKey and LaunchOptions
//    [UMessage startWithAppkey:UmengAppkey launchOptions:launchOptions];
//    NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    
    //for log
    [UMessage setLogEnabled:YES];
    
    //向微信注册wx08f5e0276199751e
    
    /** 融云功能取消，代码注释 **/
//    //完成融云的配置
//    [self initRongyunConfiguration];
//    //推送消息处理
//    [self userNotificationSetting:application];
//
//    // 融云远程推送的内容的判断
//    NSDictionary *remoteNotificationUserInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
//    if (remoteNotificationUserInfo) {
//
//        if ([[UserState sharedManager] isLogin]) {
//
//            if ([remoteNotificationUserInfo objectForKey:@"rc"]) {
//                [[_app_ getTabBar] selectTableBarIndex:2];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToRongyunCommunicationTabBarViewController" object:nil];
//            }
//        }
//    }
//
    [self startIQKeyboardManager];
    
    return YES;
}

/**
 *   融云推送处理2
 */
//注册用户通知设置
//- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
//    // register to receive notifications
//    [application registerForRemoteNotifications];
//}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    /**
     *  验证手势密码
     */
    if (get_sp(kCoreLockShareBackToHere)) {
        set_sp(nil, kCoreLockShareBackToHere);
    }else if (get_sp(KCoreLockPayMoneyBackToHere)) {
        set_sp(nil, KCoreLockPayMoneyBackToHere);
    }else if (get_sp(KCoreLockCallTelePhoneBackToHere)) {
        set_sp(nil, KCoreLockCallTelePhoneBackToHere);
    }else{
        [self applicationDidBecomeActiveShouldVerifyGesturePassword];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

//    [UIApplication sharedApplication].applicationIconBadgeNumber = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];//融云聊天未读消息数量
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

#pragma mark - 推送Delegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
 
    
    /** 融云功能取消，代码注释 **/
//    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//    [[RCIMClient sharedRCIMClient] setDeviceToken:token];

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    DLog(@"通过本地通知栏进入App!!!");
    NSDictionary *locationDict = notification.userInfo;
    
    /** 融云功能取消，代码注释 **/
//    if ([locationDict objectForKey:@"rc"]) { //聊天相关的本地通知
//        [[_app_ getTabBar] selectTableBarIndex:2];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToRongyunCommunicationTabBarViewController" object:nil];
//    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //如果注册不成功，打印错误信息，可以在网上找到对应的解决方案
    //如果注册成功，可以删掉这个方法
    NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
    
    [UMessage didReceiveRemoteNotification:userInfo];
    NSLog(@"%@",userInfo);
    

}

#pragma mark - 自定义TabBarVC相关方法
/**
 *  更换应用window的根vc
 */
- (void)changeRootView
{
    self.window.rootViewController=_tabBarViewCol;
}

- (void)showTabBar
{
    [_tabBarViewCol showTabBar];
}

- (void)hiddenTabBar
{
    [_tabBarViewCol hideCustomTabBar];
}

-(CustomTabBarViewController *)getTabBar
{
    return _tabBarViewCol;
}

#pragma mark - 交易大厅tabbar相关方法
- (void)showTradingFloorTabbar
{
//    if (self.tradingFloorTabbar != nil)
//    {
//        self.tradingFloorTabbar.tabBar.hidden = NO;
//    }
}

- (void)hideTradingFloorTabbar
{
//    if (self.tradingFloorTabbar != nil)
//    {
//        self.tradingFloorTabbar.tabBar.hidden = YES;
//    }
}
#pragma  mark - 验证手势密码
- (void)applicationDidBecomeActiveShouldVerifyGesturePassword {
    set_sp(@(1), KCoreLockVCFromWhere);
    
 
}

//- (void)userForgetGesturePasswordAndWillToSet:(NSNotification *)notification {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您尚未设置手势密码,是否需要设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
//    alert.tag = 1111;
//    set_sp(@(0), KCoreLockVCFromWhere);
//    set_sp(@(1), @"currentAlertFirstShow");
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if ([get_sp(@"currentAlertFirstShow") boolValue]) {
//            [alert show];
//        }
//        set_sp(@(0), @"currentAlertFirstShow");
//    });
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
 
    
}

-(void)dealloc {
    //移除通知
    //    [[NSNotificationCenter defaultCenter] removeObserver:KCoreLockWillSetting];
    
    /** 融云功能取消，代码注释 **/
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:RCKitDispatchMessageNotification object:nil];
}

#pragma mark --  融云配置（/** 融云功能取消，代码注释 **/）
//- (void)initRongyunConfiguration {
//
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isInConnectionStatus_UNKNOWN"]) {
//        [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"isInConnectionStatus_UNKNOWN"];//用来判断是否计入融云的“未知状态”
//    }
//
//    [[RCIM sharedRCIM] initWithAppKey:KRongyunIMAppKey];
//#pragma mark --  注册自定义消息类及 UI
//
//    //SDK 初始化方法 initWithAppKey 之后后注册消息类型
//    [[RCIM sharedRCIM] registerMessageType:[RCDTestMessage class]];
//    [[RCIM sharedRCIM] registerMessageType:[Mall_Custom_message class]];
//
//    //本地存储约定的 “系统消息助手”、“群组消息助手”
//    [self storeSystemInfo];
//
//    //设置会话列表头像和会话界面头像
//    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
//
//    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
//    //    [RCIM sharedRCIM].portraitImageViewCornerRadius = 10;
//    //开启用户信息和群组信息的持久化
//    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
//    //设置用户信息源和群组信息源
//    [RCIM sharedRCIM].userInfoDataSource = RCDDataSource;
//    [RCIM sharedRCIM].groupInfoDataSource = RCDDataSource;
//    //设置群组内用户信息源。如果不使用群名片功能，可以不设置
//    //  [RCIM sharedRCIM].groupUserInfoDataSource = RCDDataSource;
//    //  [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
//    //设置接收消息代理
//    [RCIM sharedRCIM].receiveMessageDelegate = self;
//    //    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
//    //开启输入状态监听
//    [RCIM sharedRCIM].enableTypingStatus = YES;
//    //开启发送已读回执（只支持单聊）
////    [RCIM sharedRCIM].enableReadReceipt = YES;
//    //设置显示未注册的消息
//    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
//    [RCIM sharedRCIM].showUnkownMessage = YES;
//    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
//
//    //    //设置头像为圆形
//    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
//    //    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
//
//    //通话设置群组成员列表提供者
//    [RCCall sharedRCCall].groupMemberDataSource = RCDDataSource;
//
//    if (![[UserState sharedManager] isLogin]) {
//        [[UserState sharedManager] logout];
//    }
//    //登录
//    NSString *token = [DEFAULTS objectForKey:@"userToken"];
//    NSString *userId = [DEFAULTS objectForKey:@"userId"];
//    //    NSString *userName = [DEFAULTS objectForKey:@"userName"];
//    //    NSString *password = [DEFAULTS objectForKey:@"userPwd"];
//    NSString *userNickName = [DEFAULTS objectForKey:@"userNickName"];
//    NSString *userPortraitUri = [DEFAULTS objectForKey:@"userPortraitUri"];
//    if (token.length && userId.length) {
//        RCUserInfo *_currentUserInfo =
//        [[RCUserInfo alloc] initWithUserId:userId name:userNickName portrait:userPortraitUri];
//        [RCIM sharedRCIM].currentUserInfo = _currentUserInfo;
//        {
////            [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
////                DLog(@"userId =  %@", userId);
////                NSDictionary *chatDict = @{@"service":@"Rongyun.Gettaken",@"user_id":get_sp(kUserID)? get_sp(kUserID):@"",@"sessionkey":get_sp(kSessionKey)?get_sp(kSessionKey):@""};
////                [[Mall_APIManager sharedManager] request_Rongyun_GettakenWithParams:chatDict andBlock:^(id data, NSError *error) {
////
////                    NSNumber* ret=[data objectForKey:@"ret"];
////                    if([ret isEqualToNumber:kRequestSuccess]){
////
////                        [RCDHTTPTOOL getUserInfoByUserID:userId completion:^(RCUserInfo *user) {
////                            [DEFAULTS setObject:user.portraitUri
////                                         forKey:@"userPortraitUri"];
////                            [DEFAULTS setObject:user.name
////                                         forKey:@"userNickName"];
////                            [DEFAULTS synchronize];
////                            [RCIMClient sharedRCIMClient].currentUserInfo = user;
////                            [RCIM sharedRCIM].currentUserInfo = user;
////                        }];
////                        //登陆demoserver成功之后才能调demo 的接口
////                        [RCDDataSource syncGroups];
////                        [RCDDataSource syncFriendList:userId
////                                             complete:^(NSMutableArray *result){
////                                             }];
////                    }
////                }];
////
////            } error:^(RCConnectErrorCode status) {
////                DLog(@"登陆的错误码为:%li", status);
////                if (status == RC_CONN_USER_BLOCKED) {
////                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您已经被系统屏蔽，无法登录聊天服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////                        [alert show];
////                    });
////                }
////                [[RCIM sharedRCIM] logout];
////            } tokenIncorrect:^{
////                //token过期或者不正确。
////                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
////                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
////                DLog(@"token错误");
////
////            }];
//        }//!!!!!融云登录注释
//    }
//}
//
///**
// *  本地存储约定的 “系统消息助手”、“群组消息助手”
// */
//- (void)storeSystemInfo {
//
//    RCUserInfo *systemUserInfo;
//
//    systemUserInfo = [[RCDataBaseManager shareInstance] getUserByUserId:KRongyunSystem_Assistant_ID];
//
//    if (systemUserInfo.userId == nil || [systemUserInfo.userId length] == 0) {
//        systemUserInfo = [RCUserInfo new];
//        systemUserInfo.userId =KRongyunSystem_Assistant_ID;
//        systemUserInfo.name = @"系统消息";
//        systemUserInfo.portraitUri = @"http://img01.3658mall.com/images/headimg/0_O_d4697377b043019547fcb7b503fa0be1.png";
//        [[RCDataBaseManager shareInstance] insertUserToDB:systemUserInfo];
//    }
//    //系统消息助手
//
//    NSDictionary *systeminfoDic = @{
//                                    @"username" : @"系统消息",
//                                    @"portraitUri" : @"http://img01.3658mall.com/images/headimg/0_O_d4697377b043019547fcb7b503fa0be1.png"
//                                    };
//    [[NSUserDefaults standardUserDefaults] setObject:systeminfoDic forKey:KRongyunSystem_Assistant_ID];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//    RCUserInfo *groupUserInfo;
//    groupUserInfo = [[RCDataBaseManager shareInstance] getUserByUserId:KRongyunGroup_Assistant_ID];
//    if (groupUserInfo.userId == nil || [groupUserInfo.userId length] == 0) {
//        groupUserInfo = [RCUserInfo new];
//        groupUserInfo.userId =KRongyunGroup_Assistant_ID;
//        groupUserInfo.name = @"群消息助手";
//        groupUserInfo.portraitUri = @"http://img01.3658mall.com/images/headimg/0_O_d4697377b043019547fcb7b503fa0be1.png";
//        [[RCDataBaseManager shareInstance] insertUserToDB:groupUserInfo];
//    }
//    //群消息助手
//    NSDictionary *groupinfoDic = @{
//                                   @"username" : @"群消息助手",
//                                   @"portraitUri" :  @"http://img01.3658mall.com/images/headimg/0_O_d4697377b043019547fcb7b503fa0be1.png"
//                                   };
//    [[NSUserDefaults standardUserDefaults] setObject:groupinfoDic forKey:KRongyunGroup_Assistant_ID];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//#pragma mark - RCIMConnectionStatusDelegate
//
///**
// *  网络状态变化。
// *
// *  @param status 网络状态。
// */
//- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
//    DLog(@"RCConnectionStatus = %li",status);
//    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
//        /*!
//         当前用户在其他设备上登陆，此设备被踢下线
//         */
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"  message:
//                              @"此设备已下线，您需要重新登录或修改登录密码" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil
//                              ];
//        alert.tag = 100001;
//        [alert show];
//        [[UserState sharedManager] logout];
//    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"登录过期，请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            alertView.tag = 100001;
//            [alertView show];
//            [[UserState sharedManager] logout];
//        });
//    }else if (status == ConnectionStatus_UNKNOWN) {
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isInConnectionStatus_UNKNOWN"]) {
//            NSNumber *connectionStatus_UNKNOWN_Number = [[NSUserDefaults standardUserDefaults] objectForKey:@"isInConnectionStatus_UNKNOWN"];
//            if ([connectionStatus_UNKNOWN_Number intValue]) {
//                return;
//            }
//        }
//        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"isInConnectionStatus_UNKNOWN"];
//        [[RCIM sharedRCIM] logout];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"RongyunNotifationOutOfChat" object:nil];
//        if (![[UserState sharedManager] isLogin]) {
//            [[UserState sharedManager]logout];
//            return;
//        }
//
//        NSDictionary *chatDict = @{@"service":@"Rongyun.Gettaken",@"user_id":get_sp(kUserID),@"sessionkey":get_sp(kSessionKey)};
//        [[Mall_APIManager sharedManager] request_Rongyun_GettakenWithParams:chatDict andBlock:^(id data, NSError *error) {
//
//            NSNumber* ret=[data objectForKey:@"ret"];
//            if([ret isEqualToNumber:kRequestSuccess]){
//                NSString *token = data[@"data"][@"content"][@"token"];
//                {
////                    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
////                        [DEFAULTS setObject:token forKey:@"userToken"];
////                        set_sp(@(0), @"isInBackgroundBlacklist");
////                        [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"isInConnectionStatus_UNKNOWN"];
////                    } error:^(RCConnectErrorCode status) {
////
////                        if (status == RC_CONN_USER_BLOCKED && ![get_sp(@"isInBackgroundBlacklist") intValue]) {
////                            set_sp(@(1), @"isInBackgroundBlacklist");
////                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您已经被系统屏蔽，无法登录聊天服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////                                [alert show];
////                            });
////                        }
////                    } tokenIncorrect:^{
////
////                    }];
//                }//!!!!!!融云登录注释
//            }
//        }];
//
//    }else if (status == ConnectionStatus_Connected){
//        set_sp(@(0), @"isInBackgroundBlacklist");
//        [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"isInConnectionStatus_UNKNOWN"];
//    }
//}
//
//#pragma mark - RCIMReceiveMessageDelegate
//
//- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
//    DLog(@"----message targetId %@ \n objectName = %@  \n content = %@ \n extra = %@",message.targetId,message.objectName,message.content,message.extra);
//    /**
//     *  判断消息的targetID，排除和3658商城部分的消息，排除会话ID（ -100 <= currentTargetI <= -2）
//     */
//    NSInteger currentTargetID = [message.targetId integerValue];
//    DLog(@"targetID = %li",currentTargetID);
//    if ( currentTargetID >= -100 && currentTargetID <= -2 ) {
//        [[RCIMClient sharedRCIMClient] removeConversation:message.conversationType targetId:message.targetId];
//        return;
//    }
//
//    /**
//     *  系统消息同意
//     */
//    if ([message.targetId isEqualToString:KRongyunSystem_Assistant_ID]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reBackToChatListViewController" object:nil];//通知由会话界面返回会话列表
//        if ([message.content isMemberOfClass:[RCContactNotificationMessage class]]) {
//            RCContactNotificationMessage *_contactNotificationMessage = (RCContactNotificationMessage*)message.content;
//            DLog(@"operation = %@ \ntargetUserId = %@ ,sourceUserId = %@ message =%@ extra= %@",_contactNotificationMessage.operation,_contactNotificationMessage.targetUserId,_contactNotificationMessage.sourceUserId,_contactNotificationMessage.message,_contactNotificationMessage.extra);
//            if ([_contactNotificationMessage.operation isEqualToString:ContactNotificationMessage_ContactOperationAcceptResponse]) {//同意请求
//                RCInformationNotificationMessage* msg = [RCInformationNotificationMessage notificationWithMessage:@"我们已经是好友了，快来聊天吧！" extra:@""];
//                RCMessage *messageCurrent = [[RCIMClient sharedRCIMClient] insertOutgoingMessage:ConversationType_PRIVATE targetId:_contactNotificationMessage.sourceUserId sentStatus:SentStatus_RECEIVED content:msg];
//                DLog(@"messagetag = %@",messageCurrent.targetId);
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"kRCNeedReloadDiscussionListNotification" object:nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatFriendListNotifation" object:nil];
//            }
//        }
//    }
//    /**
//     *  群助手
//     */
//    else if ([message.targetId isEqualToString:KRongyunGroup_Assistant_ID]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reBackToChatListViewController" object:nil];//通知由会话界面返回会话列表
//        if ([message.content isMemberOfClass:[RCGroupNotificationMessage class]]) {
//            RCGroupNotificationMessage *groupNotificationMessage = (RCGroupNotificationMessage*)message.content;
//            DLog(@"message.objectName = %@ \n operatorUserId = %@",message.objectName,groupNotificationMessage.operatorUserId);
//            NSData *jsonData = [groupNotificationMessage.data dataUsingEncoding:NSUTF8StringEncoding];
//            NSError *err;
//            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//            DLog(@"jsonDict = %@",jsonDict);
//            NSString *groupNotifationTipsString = nil;
//            NSMutableDictionary *groupNotifationTipsDict = [NSMutableDictionary dictionary];
//
//            if ([groupNotificationMessage.operation isEqualToString:@"Dismiss"]) { //解散群
//                if (jsonDict && jsonDict[@"group_id"]) {
//                    [[RCDRCIMDataSource shareInstance] syncGroups];//刷新群组列表信息
//                    [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_GROUP targetId:jsonDict[@"group_id"]]; //清空会话信息
//                    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_GROUP targetId:jsonDict[@"group_id"]];//删除会话
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kRCNeedReloadDiscussionListNotification" object:nil];
//                    [groupNotifationTipsDict setObject:jsonDict[@"operatorNickname"] forKey:@"operatorNickname"];
//                    NSMutableDictionary * tempDataDict = [[NSMutableDictionary alloc]initWithDictionary:groupNotifationTipsDict];
//                    DLog(@"tempda = %@",tempDataDict);
//                    [groupNotifationTipsDict setObject:tempDataDict forKey:@"data"];
//                    NSError *parseError = nil;
//                    NSData *jsonData_dict = [NSJSONSerialization dataWithJSONObject:groupNotifationTipsDict options:NSJSONWritingPrettyPrinted error:&parseError];
//                    groupNotifationTipsString = [[NSString alloc] initWithData:jsonData_dict encoding:NSUTF8StringEncoding];
//                    DLog(@"systemNotifationTipsString = %@",groupNotifationTipsString);
//                    groupNotificationMessage.data =groupNotifationTipsString;
//                    message.content = groupNotificationMessage;
//                }
//            }else if ([groupNotificationMessage.operation isEqualToString:GroupNotificationMessage_GroupOperationAdd] || [groupNotificationMessage.operation isEqualToString:GroupNotificationMessage_GroupOperationQuit] || [groupNotificationMessage.operation isEqualToString:GroupNotificationMessage_GroupOperationKicked]) {//有成员加入群组的通知
//
//                {
//                    RCDGroupInfo *group = [RCDGroupInfo new];
//                    NSArray *usersArray;
//                    if (jsonDict) {
//                        usersArray = jsonDict[@"targetUse"];
//                        group.groupId = jsonDict[@"group_id"];
//                        group.groupName = jsonDict[@"group_name"];
//                        group.portraitUri = jsonDict[@"group_head"];
//
//                        [groupNotifationTipsDict setObject:jsonDict[@"operatorNickname"] forKey:@"operatorNickname"];
//                        NSMutableArray *usersIDArray = [NSMutableArray array];
//                        NSMutableArray *usersNameArray = [NSMutableArray array];
//                        for (NSDictionary *user in usersArray) {
//                            [usersIDArray addObject:user[@"userid"]];
//                            [usersNameArray addObject:user[@"username"]];
//                        }
//                        [groupNotifationTipsDict setObject:usersIDArray forKey:@"targetUserIds"];
//                        [groupNotifationTipsDict setObject:usersNameArray forKey:@"targetUserDisplayNames"];
//                        NSMutableDictionary * tempDataDict = [[NSMutableDictionary alloc]initWithDictionary:groupNotifationTipsDict];
//                        DLog(@"tempda = %@",tempDataDict);
//                        [groupNotifationTipsDict setObject:tempDataDict forKey:@"data"];
//                    }
//                    NSError *parseError = nil;
//                    NSData *jsonData_dict = [NSJSONSerialization dataWithJSONObject:groupNotifationTipsDict options:NSJSONWritingPrettyPrinted error:&parseError];
//                    groupNotifationTipsString = [[NSString alloc] initWithData:jsonData_dict encoding:NSUTF8StringEncoding];
//                    DLog(@"roupNotifationTipsString = %@",groupNotifationTipsString);
//                    groupNotificationMessage.data =groupNotifationTipsString;
//                    message.content = groupNotificationMessage;
//
//                    if (group.groupId) {
//                        //                        [[RCDataBaseManager shareInstance]insertGroupToDB:group];
//                        [[RCDRCIMDataSource shareInstance] syncGroups];//刷新群组列表
//                        if ([groupNotificationMessage.operation isEqualToString:GroupNotificationMessage_GroupOperationQuit] && [groupNotificationMessage.operatorUserId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {//自己主动退群时
//
//                        }else  {
//
//                            [[RCIMClient sharedRCIMClient] insertOutgoingMessage:ConversationType_GROUP targetId:group.groupId sentStatus:SentStatus_RECEIVED content:message.content];
//                        }
//                    }
//
//                    //判断被踢出群时清除会话
//                    if ([groupNotificationMessage.operation isEqualToString:GroupNotificationMessage_GroupOperationKicked]) {
//                        for (NSDictionary *userDict in usersArray) {
//                            if (userDict[@"userid"]) {
//                                if ([userDict[@"userid"] isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
//                                    if (group.groupId) {
//                                        [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_GROUP targetId:group.groupId];
//                                        [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_GROUP targetId:group.groupId];
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kRCNeedReloadDiscussionListNotification" object:nil];
//                }
//            }
//        }
//    }
//
//    /**
//     * 自定义通知消息
//     */
//    else if ([message.objectName isEqualToString:@"Mall:Custom"]) {
//        if ([message.content isMemberOfClass:[Mall_Custom_message class]]) {
//
//            Mall_Custom_message *mall_Custom_message = (Mall_Custom_message*)message.content;
//            DLog(@"operation = %@ \n targetUserId = %@ \n sourceUserId = %@ ",mall_Custom_message.operation,mall_Custom_message.targetUserId,mall_Custom_message.sourceUserId);
//            if ([mall_Custom_message.operation isEqualToString:RCMallCustomMessageNotification_DeleteFriends]) {//删除联系人
//                [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:message.targetId]; //清空会话信息
//                [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:message.targetId];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatFriendListNotifation" object:nil];
//            }
//        }
//    }
//}
//
////设置群组通知消息没有提示音
//-(BOOL)onRCIMCustomAlertSound:(RCMessage*)message {
//    if ([message.content isMemberOfClass:[RCGroupNotificationMessage class]]) {
//        return YES;
//    }
//    return NO;
//}
//
//
//#pragma mark - 融云推送消息设置
//
//- (void)userNotificationSetting:(UIApplication *)application  {
//
//    /**
//     *  融云推送处理1
//     */
//    if ([application
//         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//
//        /**    ios9.0+ 版本以上重复通知bug处理情况（注释掉下面代码和上面的
//         application: didRegisterUserNotificationSettings:)目前是有效果的
//         I had a similar issue, and in my case problem was in calling method registerUserNotificationSettings: two times. Seems that calling this method more than 1 time leads to duplicate notifications on iOS 9.
//
//         So if you have the same situation, try these two steps:
//
//         Remove all extra calls of registerUserNotificationSettings: in your code.
//         Then Reinstall the app.
//         This should fix the issue.
//         */
//
//        //        //注册推送, 用于iOS8以及iOS8之后的系统
//        //        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
//        //        [application registerUserNotificationSettings:settings];
//    } else {
//        //注册推送，用于iOS8之前的系统
//        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
//        UIRemoteNotificationTypeAlert |
//        UIRemoteNotificationTypeSound;
//        [application registerForRemoteNotificationTypes:myTypes];
//    }
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification:) name:RCKitDispatchMessageNotification object:nil];
//}
//
//- (void)didReceiveMessageNotification:(NSNotification *)notification {
//    RCMessage *message = notification.object;
//    if (message.messageDirection == MessageDirection_RECEIVE && [[message.content class] persistentFlag] & MessagePersistent_ISCOUNTED) {
//        if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
//            //            [UIApplication sharedApplication].applicationIconBadgeNumber =
//            //            [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
//            [UIApplication sharedApplication].applicationIconBadgeNumber = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
//        }
//    }
//}

- (void)startIQKeyboardManager{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont systemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

@end

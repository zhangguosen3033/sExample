//
//  AppDelegate.h
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/2.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarViewController.h"
#import "UMSocial.h"
#import "UMessage.h"

/** 融云功能取消，代码注释 **/
//#import <RongIMKit/RongIMKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    CustomTabBarViewController *_tabBarViewCol;
    
}
@property (strong, nonatomic) UIWindow *window;

- (void)showTabBar;
- (void)hiddenTabBar;
- (void)changeRootView;
-(CustomTabBarViewController *)getTabBar;

- (void)showTradingFloorTabbar;
- (void)hideTradingFloorTabbar;

//消息盒子开关（0 是隐藏状态  1是打开状态）
@property(nonatomic,assign) int  kNewsSwitch;

#pragma mark -  版本更新提示相关属性
/**
 是否正在检查更新（即正在请求Version.IsNew接口） 如果正在检查更新则不再重复请求，Version.IsNew网络请求开始之后赋值为YES 结束之后赋值为NO
 */
@property (assign, nonatomic) BOOL isCheckingUpdate;
/**
 是否已弹出更新提示框 如果已经弹出过则不再进行更新检查，更新提示弹框显示之后赋值为YES（如果更新不是强制更新 则在弹框关闭之后赋值为NO，此操作是为兼容应用开启时为提示更新 并且操作中更新状态转变为强制更新的状况）
 */
@property (assign, nonatomic) BOOL isShownUpdatePromptView;
/**
 更新提示弹框是否正显示在屏幕上，添加这个属性 主要是用来控制首页VIP大礼包弹框的显示（如果已经展示了版本更新弹框 则不再显示首页VIP大礼包弹框）
 */
@property (assign, nonatomic) BOOL isUpdatePromptVisible;

@end


//
//  APIUrl.h
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/8.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#ifndef mall3658_APIUrl_h
#define mall3658_APIUrl_h


#endif

#define Code_CookieData      @"sessionCookies"

/*api接口请求都放这里*/

#pragma mark BaseUrl
//生产环境
//#define kNetPath_Code_Base      @"https://prodapi.jqian.com/Public"

//仿生环境
//#define kNetPath_Code_Base      @"https://fzapi.jqian.com/Public"

//测试环境
#define kNetPath_Code_Base        @"https://devapi.jqian.com/Public"


//@"http://api.3658mall.com/Public"
//@"https://api.3658mall.net/"

#define kUpdateUrl @"https://appsto.re/cn/PV9Z-.i"

#pragma mark ConfigUrl


//正式站链接（3.0版本以后都用这个）
#define kNetPath_Code_Task         @"supp/"

#define kSessionKey @"3658mall_SessionKey"
#define kUserID @"3658mall_UserID"


//#define kIsUsernameChanged @"isUsernameChanged"

#define kCurrentUser @"3658mall_CurrentUser"
#define kRealName @"3658mall_realName"


#define kLogouClearMissionListState @"logoumission"


#define kFirstGetInAppIsNew @"kFirstGetInAppIsNew"

#define kAppId @"1187772950"


/**
 *  网络请求返回的状态码
 */

//请求成功
#define kRequestSuccess @200

//未授权（用户未登录）
#define kRequestUserNoLogin @401

//没有数据
#define kRequestNotHaveData @420

//请求错误
#define kRequestError @400

#define kVersionTooOld @440
//账户被冻结
#define kRequestAccountFrozen @431


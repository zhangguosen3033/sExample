//
//  SHEnum.h
//  shMetro3.0
//
//  Created by syzhou on 13-4-12.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#ifndef BestOne_SHEnum_h
#define BestOne_SHEnum_h

typedef enum
{
    ActionSheetStyleShare,
    ActionSheetStyleDia,
    ActionSheetstylePhoto
}ActionSheetStyle;

typedef enum
{
    MapViewDetailMode,
    MapViewServalMode
}MapViewMode;

typedef NS_ENUM(NSUInteger, PullRefreshType) {
    PullRefreshType_Refresh,
    PullRefreshType_LoadMore,
};

/**
 共享代理身份
 */
typedef NS_ENUM(NSUInteger, ShareAgentType) {
    /**
     共享代理身份 - 代理
     */
    ShareAgentType_Agent = 0,
    /**
     共享代理身份 - 代理推广员
     */
    ShareAgentType_Promoter,
    /**
     共享代理身份 - 平台直属推广员
     */
    ShareAgentType_PlatformPromoter,
    /**
     共享代理身份 - 未申请
     */
    ShareAgentType_Unapplied,
};

#endif

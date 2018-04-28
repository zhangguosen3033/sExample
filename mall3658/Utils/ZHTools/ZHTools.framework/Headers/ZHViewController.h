//
//  ZHViewController.h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/12/9.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHViewController : UIViewController

/**
 状态栏+导航栏
 */
@property (strong, nonatomic) UIView *topBar;

/**
 左侧按钮
 */
@property (strong, nonatomic) UIButton *leftNavigationButton;

/**
 导航栏标题
 */
@property (strong, nonatomic) UILabel *navigationTitleLabel;

/**
 右侧按钮
 */
@property (strong, nonatomic) UIButton *rightNavigationButton;

/**
 禁用系统侧滑返回，默认NO
 */
@property (assign, nonatomic) BOOL disableSystemSlideBack;

/*!
 *
 *  @brief  左侧按钮点击事件
 *
 */
- (void)leftNavigationButtonAction;

/*!
 *
 *  @brief  右侧按钮点击事件
 *
 */
- (void)rightNavigationButtonAction;

@end

//
//  WelcomeViewController.h
//  mall3658
//
//  Created by yangsu on 15/9/18.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "BaseNavigationController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface WelcomeViewController : BaseNavigationController

@property (nonatomic,strong) UIButton *btn;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

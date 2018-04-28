//
//  LineChartViewController.h
//  mall3658
//
//  Created by ygkj on 2017/9/11.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "BaseNavigationController.h"
#import <UIKit/UIKit.h>

@interface LineChartViewController : BaseNavigationController

@property (nonatomic, strong) UILabel *sevenLbel;
@property (nonatomic, strong) UILabel *thirtyLbel;

@property (nonatomic, strong) UIView *sevenView;
@property (nonatomic, strong) UIView *thirtyView;

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSDictionary *sevenDic;
@property (nonatomic, strong) NSDictionary *thirtyDic;


@end

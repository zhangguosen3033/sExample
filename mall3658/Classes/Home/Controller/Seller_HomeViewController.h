//
//  Seller_HomeViewController.h
//  mall3658
//
//  Created by lz on 16/6/12.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "BaseNavigationController.h"
#import "GSRunningMaLight.h"

@interface Seller_HomeViewController : BaseNavigationController

@property(nonatomic,strong) UITableView * customTableView ;
@property(nonatomic,strong)GSRunningMaLight * runningMaLight;//跑马灯

@end


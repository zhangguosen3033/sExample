//
//  NearbymerchantsViewController.h
//  mall3658
//
//  Created by ygkj on 2017/9/5.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "BaseNavigationController.h"

@interface NearbymerchantsViewController : BaseNavigationController
@property(nonatomic,strong) UITableView * customTableView ;

@property(nonatomic,strong) NSString * titleStr ;
@property(nonatomic,assign) NSInteger  typeNum ;//根据数字进行的区分类型
@property(nonatomic,assign) BOOL isUnNormal ; //异常的警告图标



@end

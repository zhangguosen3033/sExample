//
//  NearbymerchantsDetailViewController.h
//  mall3658
//
//  Created by ygkj on 2017/9/5.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "BaseNavigationController.h"
#import  <CoreLocation/CoreLocation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface NearbymerchantsDetailViewController : BaseNavigationController

@property(nonatomic,strong) UITableView * customTableView ;
@property(nonatomic,strong) UIButton *goToMap; //路径规划

@property(nonatomic,strong) UIView * bottomView ;
@property(nonatomic,strong) UIButton *goToPay;

@property(nonatomic,strong) NSString *storeId;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;

//当前经纬度
@property (nonatomic) CLLocationCoordinate2D nowDetailCoordinate;
@property (nonatomic) CLLocationCoordinate2D nowDetailDestionCoordinate;
@property(nonatomic,strong) NSString *nowCity;

@property(nonatomic,strong) NSString *infoDetial;//简介可展开的内容
@property(nonatomic,strong) NSString *cityDetial;//展示的当前详细信息

@end

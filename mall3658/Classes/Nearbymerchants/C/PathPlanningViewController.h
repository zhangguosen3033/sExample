//
//  PathPlanningViewController.h
//  mall3658
//
//  Created by ygkj on 2017/9/17.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "BaseNavigationController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "CommonUtility.h"
#import "MANaviRoute.h"
@interface PathPlanningViewController : BaseNavigationController

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapRoute *route;
/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;

@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;
/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;
@property(nonatomic,strong) NSString *mapCity;

@property (nonatomic) MANaviAnnotationType type;

@end

//
//  PathPlanningViewController.m
//  mall3658
//
//  Created by ygkj on 2017/9/17.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "PathPlanningViewController.h"
#import "ListSegmentView.h"
static const NSInteger RoutePlanningPaddingEdge                    = 20;

@interface PathPlanningViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,MAMapViewDelegate>
{
    ListSegmentView *listView;
    NSNumber *currentStart;//当前的选择模块
    int page;
    
}
@end

@implementation PathPlanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Toolkit getColor:hex_f3f3f3];
    _topView.backgroundColor =[Toolkit getColor:hex_1D85FF];
    _lblTitle.text = @"路径规划";
    _lblTitle.textColor = [UIColor whiteColor];
    
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, (NAV_MAXY + 1 + 45), SCREEN_WIDTH, SCREEN_HEIGHT- (NAV_MAXY + 1 + 45))];
    [self.mapView setDelegate:self];
    self.mapView.showsUserLocation = YES;
    [self.mapView setZoomLevel:13.1 animated:YES];
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.centerCoordinate = self.startCoordinate;
    self.mapView.showsCompass= NO;//隐藏罗盘
    [self.view addSubview:self.mapView];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    //默认加载的规划方式
    currentStart = @0;
    //先清除所有标识
    [self.naviRoute removeFromMapView];
    self.startAnnotation.coordinate = self.startCoordinate;
    self.destinationAnnotation.coordinate = self.destinationCoordinate;
    
    AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                           longitude:self.startCoordinate.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                longitude:self.destinationCoordinate.longitude];
    [self.search AMapWalkingRouteSearch:navi];
    
    
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title      = @"起点";
    startAnnotation.subtitle   = @"从此处出发";
    self.startAnnotation = startAnnotation;
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title      = @"终点";
    destinationAnnotation.subtitle   = @"到达终点";
    self.destinationAnnotation = destinationAnnotation;
    
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];
    
    //创建头部的滚动试图
    listView=[[ListSegmentView alloc]initWithFrame:CGRectMake(0, NAV_MAXY + 1, self.view.frame.size.width, 45) titles:@[@"步行", @"公交", @"驾车"] btn_w:SCREEN_WIDTH/3 clickBlick:^void(NSInteger index) {
        NSLog(@"-----%ld",index -1);
        currentStart = [NSNumber numberWithInteger:(index -1)] ;  //当前选中状态
        
        [self pathPlaneMethodWith:currentStart];
        
    }];
    //以下属性可以根据需求修改
    listView.titleSelectColor=[Toolkit getColor:hex_1D85FF];
    
    
    
    
    [self.view addSubview:listView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}
-(void)pathPlaneMethodWith:(NSNumber *)currentNum{
    
    switch ([currentNum intValue]) {
        case 0:
        {
            //先清除所有标识
            [self.naviRoute removeFromMapView];
            self.startAnnotation.coordinate = self.startCoordinate;
            self.destinationAnnotation.coordinate = self.destinationCoordinate;
            
            AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];
            /* 出发点. */
            navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                                   longitude:self.startCoordinate.longitude];
            /* 目的地. */
            navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                        longitude:self.destinationCoordinate.longitude];
            [self.search AMapWalkingRouteSearch:navi];
            
        }
            break;
            
        case 1:
        {
            //这里使用的是公交路径
            //先清除所有标识
            [self.naviRoute removeFromMapView];
            self.startAnnotation.coordinate = self.startCoordinate;
            self.destinationAnnotation.coordinate = self.destinationCoordinate;
            
            AMapTransitRouteSearchRequest *navi = [[AMapTransitRouteSearchRequest alloc] init];
            /* 出发点. */
            navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                                   longitude:self.startCoordinate.longitude];
            /* 目的地. */
            navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                        longitude:self.destinationCoordinate.longitude];
            navi.city = self.mapCity;
            [self.search AMapTransitRouteSearch:navi];
            
        }
            break;
            
        case 2:
        {
            //这里使用的是驾车路径
            //先清除所有标识
            [self.naviRoute removeFromMapView];
            self.startAnnotation.coordinate = self.startCoordinate;
            self.destinationAnnotation.coordinate = self.destinationCoordinate;
            
            AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
            /* 出发点. */
            navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                                   longitude:self.startCoordinate.longitude];
            /* 目的地. */
            navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                        longitude:self.destinationCoordinate.longitude];
            [self.search AMapDrivingRouteSearch:navi];
            
        }
            break;
        default:
            break;
    }
    
}

//实现路径搜索的回调函数
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if(response.route == nil)
    {
        [SVProgressHUD showInfoWithStatus:@"暂无信息，请选择其他出行方式"];
        
        return;
    }
    AMapPath *path = response.route.paths[0]; //选择一条路径
    AMapStep *step = path.steps[0]; //这个路径上的导航路段数组
    NSLog(@"%@",step.polyline);   //此路段坐标点字符串
    
    switch ([currentStart intValue]) {
        case 0:
        {
            self.type = MANaviAnnotationTypeWalking;
            
            if (response.route.paths.count >0) {
                self.naviRoute = [MANaviRoute naviRouteForPath:path withNaviType:self.type showTraffic:NO startPoint:[AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude longitude:self.destinationCoordinate.longitude]];
                [self.naviRoute addToMapView:self.mapView];

            }else{
                [SVProgressHUD showInfoWithStatus:@"暂无步行信息，请选择其他方式"];
                
            }
            
        }
            break;
        case 1:
        {
            self.type = MANaviAnnotationTypeBus;
            if (response.route.transits.count >0) {
                self.naviRoute = [MANaviRoute naviRouteForTransit:response.route.transits[0] startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude longitude:self.destinationCoordinate.longitude]];
                [self.naviRoute addToMapView:self.mapView];
            }else{
                [SVProgressHUD showInfoWithStatus:@"暂无公交信息，请选择其他方式"];
            }
            
            
        }
            break;
        case 2:
        {
            self.type = MANaviAnnotationTypeDrive;
            if (response.route.paths.count >0) {
                self.naviRoute = [MANaviRoute naviRouteForPath:path withNaviType:self.type showTraffic:NO startPoint:[AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude longitude:self.destinationCoordinate.longitude]];
                [self.naviRoute addToMapView:self.mapView];
            }else{
                [SVProgressHUD showInfoWithStatus:@"暂无驾车信息，请选择其他方式"];
                
            }
            
        }
            break;
            
        default:
            break;
    }
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
}


#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 5;
        polylineRenderer.lineDashPattern = @[@10, @15];
        polylineRenderer.strokeColor = [UIColor blueColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 5;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
            polylineRenderer.strokeColor = [UIColor blueColor];;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway)
        {
            polylineRenderer.strokeColor = [UIColor blueColor];;
        }
        else
        {
            polylineRenderer.strokeColor = [UIColor blueColor];;
        }
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        
        polylineRenderer.lineWidth = 5;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        polylineRenderer.gradient = YES;
        
        return polylineRenderer;
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
        
        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.image = nil;
        
        if ([annotation isKindOfClass:[MANaviAnnotation class]])
        {
            switch (((MANaviAnnotation*)annotation).type)
            {
                case MANaviAnnotationTypeRailway:
                    poiAnnotationView.image = [UIImage imageNamed:@"icon_location@2x"];
                    break;
                    
                case MANaviAnnotationTypeBus:
                    poiAnnotationView.image = [UIImage imageNamed:@"icon_location@2x"];
                    break;
                    
                case MANaviAnnotationTypeDrive:
                    poiAnnotationView.image = [UIImage imageNamed:@"icon_location@2x"];
                    break;
                    
                case MANaviAnnotationTypeWalking:
                    poiAnnotationView.image = [UIImage imageNamed:@"icon_location@2x"];
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            /* 起点. */
            if ([[annotation title] isEqualToString:@"起点"])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"icon_location@2x"];
            }
            /* 终点. */
            else if([[annotation title] isEqualToString:@"终点"])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"icon_location@2x"];
            }
            
        }
        
        return poiAnnotationView;
    }
    
    return nil;
}


- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

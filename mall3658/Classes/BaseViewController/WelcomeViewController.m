//
//  WelcomeViewController.m
//  mall3658
//
//  Created by yangsu on 15/9/18.
//  Copyright (c) 2015年 Leo. All rights reserved.
//


#import "WelcomeViewController.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>
{
    
    UIPageControl *_page;
}

@end

@implementation WelcomeViewController
@synthesize btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _topView.backgroundColor=[UIColor whiteColor];
//    NSArray *imageArray = @[@"引导页1.png",@"引导页2.png",@"引导页3.png",@"引导页4.png"];
    
     NSArray *imageArray = @[@"引导页A.png",@"引导页B.png",@"引导页C.png",@"引导页D.png"];
    
    //添加滚动试图
    UIScrollView *scroll = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT)];
    scroll.contentSize = CGSizeMake(imageArray.count*SCREEN_WIDTH, 0);
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    scroll.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:scroll];
    
    for (int i=0; i<imageArray.count; i++)
    {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        imageV.image = [UIImage imageNamed:imageArray[i]];
        [scroll addSubview:imageV];
        
    }
    
    
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-30, SCREEN_HEIGHT-80, 60, 10)];
    _page.numberOfPages = 5;
    _page.currentPageIndicatorTintColor = [UIColor redColor];
    _page.pageIndicatorTintColor = [UIColor grayColor];
    //    [self.view addSubview:_page];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*(imageArray.count-0.5)-150, SCREEN_HEIGHT-150, 300, 150)];
    //    [btn setTitle:@"立刻体验" forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 15;
    btn.backgroundColor = [UIColor clearColor];
    
    [btn addTarget:self action:@selector(goToHomeController) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btn];
    
    //设置定位
    [self setMapLocation];

}
#pragma mark -获取定位
-(void)setMapLocation{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollViewDelegate 代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger pageNum = scrollView.contentOffset.x/SCREEN_WIDTH;
    _page.currentPage = pageNum;
    NSLog(@"%ld",(long)pageNum);
    
    
}
//跳转到主页面
-(void)goToHomeController{
    
    [_app_ changeRootView];
    
}


@end

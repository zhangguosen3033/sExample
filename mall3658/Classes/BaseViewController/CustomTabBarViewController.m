////
////  CustomTabBarViewController.m
////  Blinq
////
////  Created by Sugar on 13-8-12.
////  Copyright (c) 2013年 Sugar Hou. All rights reserved.
////
//
#import "CustomTabBarViewController.h"
#import "CommenDef.h"
#import "Toolkit.h"
#import "FlatButton.h"
#import "UIImage+NSBundle.h"

#import "Seller_HomeViewController.h"
#import "NearbymerchantsViewController.h"
#import "NearbymerchantsDetailViewController.h"
#define tabBarButtonNum 2

@interface CustomTabBarViewController ()<UINavigationControllerDelegate>
{
    NSArray *_arrayImages;
    UIButton *_btnSelected;
    UIView *_tabBarBG;
}
@end

@implementation CustomTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //    //隐藏系统tabbar
    self.tabBar.hidden = YES;
    
    self.hidesBottomBarWhenPushed = YES;
    
    NSArray *arrayImages_H = [[NSArray alloc] initWithObjects:@"首页-色@2x.png", @"我的---面@2x.png", nil];
    NSArray *arrayImages = [[NSArray alloc] initWithObjects:@"tabBtn1_1@2x.png", @"我的---线@2x.png",  nil];
    
    _tabBarBG = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TabBar_HEIGHT, SCREEN_WIDTH, TabBar_HEIGHT)];
    _tabBarBG.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1];
    _tabBarBG.alpha=1;
    UIView* slider=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
    slider.backgroundColor=[UIColor lightGrayColor];
    [_tabBarBG addSubview:slider];
    
    [self.view addSubview:_tabBarBG];
    UIImageView *imageline1=[[UIImageView alloc]initWithFrame:CGRectMake(0,0.3, SCREEN_WIDTH, 0.3)];
    imageline1.backgroundColor=[UIColor colorWithRed:0.88 green:0.89 blue:0.89 alpha:1];
    [self.view addSubview:imageline1];
    //    //自定义tabbar的按钮和图片
    
    int tabBarWitdh = SCREEN_WIDTH * 1.0f / tabBarButtonNum;
    for(int i = 0; i < tabBarButtonNum; i++)
    {
        CGRect frame;
        if(i==4){
            frame=CGRectMake(i * tabBarWitdh, -15, tabBarWitdh, 94);
        }else{
            frame=CGRectMake(i * tabBarWitdh, 4, tabBarWitdh, 49);
        }
        FlatButton * btnTabBar = [FlatButton button];
        btnTabBar.frame=frame;
        
        [btnTabBar setImage: [UIImage imageWithBundleName:[arrayImages objectAtIndex:i]] forState:UIControlStateNormal];
        [btnTabBar setImage:[UIImage imageWithBundleName:[arrayImages_H objectAtIndex:i]]forState:UIControlStateSelected] ;
        btnTabBar.tag = i + 1000;
        [btnTabBar addTarget:self action:@selector(onTabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarBG addSubview:btnTabBar];
    }
    
    /**
     *  第1栏   首页VC
     */
    Seller_HomeViewController *homeVC=[[Seller_HomeViewController alloc]init];
    /**
     *  第2个 附件商家VC
     */
    NearbymerchantsDetailViewController* shangjia=[[NearbymerchantsDetailViewController alloc] init];
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (BaseNavigationController *vc in @[homeVC, shangjia]) {
        
        WS(ws);
        vc.didMoveToParentViewControllerBlock = ^(id yzhObject) {
            
            [ws handleTabBar4ViewController:yzhObject];

        };
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        if ([Toolkit isSystemIOS7]||[Toolkit isSystemIOS8]) {
            vc.automaticallyAdjustsScrollViewInsets=NO;
        }
        navigationController.navigationBar.hidden = YES;
        navigationController.delegate = self;
        [array addObject:navigationController];
    }
    
    //加入到真正的tabbar
    self.viewControllers = array;
    
    UIButton *btnSender = (UIButton *)[self.view viewWithTag:0 + 1000];
    [self onTabButtonPressed:btnSender];
}

-(void)selectWhenTabItem:(id)sender{
    
}
-(void)showLoginViewController:(int)itemTag isAnimation:(BOOL)isAnimate{
    
}

//点击tab页时的响应

-(void)onTabButtonPressed:(UIButton *)sender
{
    //    if (![[UserState sharedManager] isLogin] && sender.tag == (1000 + tabBarButtonNum-1)) {
    //        LogInViewController *logoin = [[LogInViewController alloc]init];
    //
    //        logoin.loginSuccessed =^(LogInViewController *loginVC) {
    //            [[_app_ getTabBar] selectTableBarIndex:2];
    //        };
    //        [[[_app_ getTabBar] selectedViewController] pushViewController:logoin animated:YES];
    //        return;
    //    }
    
    if (_btnSelected == sender)
        return ;
    //添加tabbar切换动画
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.2f];
    [animation setType:kCATransitionFade];//波纹效果
    
    if (sender.tag>_btnSelected.tag) {
        animation.subtype=kCATransitionFromLeft;
        
    }else{
        animation.subtype=kCATransitionFromRight;
    }
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[self.view layer]addAnimation:animation forKey:@"switchView"];
    
    //跳转页面
    if (_btnSelected)
        _btnSelected.selected = !_btnSelected.selected;
    
    sender.selected = !sender.selected;
    _btnSelected = sender;
    
    [self setSelectedIndex:sender.tag - 1000];
}
- (void)selectTableBarIndex:(NSInteger)index
{
    if (index < 0 || index > 5)
        return ;
    UIButton *btnSender = (UIButton *)[self.view viewWithTag:index + 1000];
    [self onTabButtonPressed:btnSender];
}

//隐藏tabbar
- (void)hideCustomTabBar
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _tabBarBG.frame=CGRectMake(0, SCREEN_HEIGHT*1.3, SCREEN_WIDTH, _tabBarBG.frame.size.height);
    [UIView commitAnimations];
    
}
//显示tabbar
-(void)showTabBar
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _tabBarBG.frame=CGRectMake(0, SCREEN_HEIGHT - TabBar_HEIGHT, SCREEN_WIDTH, _tabBarBG.frame.size.height);
    [UIView commitAnimations];
}

- (void)goToHomePage
{
    [self setSelectedIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//每次点击切换页面都走这个代理方法，判断如果等于1，显示，证明在4个主页面上，等于2，证明进入了下级页面，隐藏，下面就都隐藏了
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self handleTabBar4ViewController:viewController];
    
}

- (void)handleTabBar4ViewController:(UIViewController *)viewController {
    
    if (viewController.navigationController.viewControllers.count == 1) {
        
        [self showTabBar];
        
    } else if (viewController.navigationController.viewControllers.count == 2) {
        
        [self hideCustomTabBar];
        
    }
}

@end

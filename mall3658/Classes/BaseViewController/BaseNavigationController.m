//
//  BaseNavigationController.m
//  Blinq
//
//  Created by user on 13-9-2.
//  Copyright (c) 2013年 Sugar Hou. All rights reserved.
//

#import "BaseNavigationController.h"
#import "CommenDef.h"
#import "Toolkit.h"
#import "UIImage+NSBundle.h"

@interface BaseNavigationController ()

@property (assign, nonatomic) BOOL formerPopGestureRecognizerEnabled;

@end


@implementation BaseNavigationController

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
	// Do any additional setup after loading the view.
    
    NSLog(@"%@", NSStringFromClass([self class]));
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    _orginY = StatusBar_HEIGHT;
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBar_HEIGHT + _orginY)];
    _topView.userInteractionEnabled = YES;
    _topView.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.96 alpha:1];
    [self.view addSubview:_topView];
    
    _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftImageWidth, _orginY  + 0, SCREEN_WIDTH - 2 * DefaultLeftImageWidth, NavigationBar_HEIGHT)];
    _lblTitle.backgroundColor = [UIColor clearColor];
    _lblTitle.adjustsFontSizeToFitWidth = YES;
    _lblTitle.textColor = [UIColor darkGrayColor];
    _lblTitle.font=[UIFont boldSystemFontOfSize:18];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    _lblTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    _lblTitle.numberOfLines = 0;
    _lblTitle.center = CGPointMake(_topView.center.x, _lblTitle.center.y);
    [self.view addSubview:_lblTitle];
    
    _imgLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, _orginY, 60, NavigationBar_HEIGHT)];
    _imgLeft.backgroundColor = [UIColor clearColor];
    _imgLeft.center = CGPointMake(_imgLeft.center.x, _lblTitle.center.y);
    [self.view addSubview:_imgLeft];
    
    _lblLeft = [[UILabel alloc] initWithFrame:CGRectMake(0,_orginY+NavigationBar_HEIGHT-10 ,60,10)];
    
    _lblLeft.numberOfLines = 0;
    _lblLeft.textAlignment=NSTextAlignmentCenter;
    _lblLeft.font = [UIFont systemFontOfSize:8];
    _lblLeft.textColor = [UIColor darkGrayColor];
    _lblLeft.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_lblLeft];
    

    _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, _orginY, 60, NavigationBar_HEIGHT)];
    [_btnLeft addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLeft setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"navi_back_btn@2x.png"]] forState:UIControlStateNormal];
    _btnLeft.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_btnLeft];
    
    _imgRight = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60 , _orginY, 60, NavigationBar_HEIGHT)];
    _imgRight.backgroundColor = [UIColor clearColor];
    _imgRight.center = CGPointMake(_imgRight.center.x, _imgLeft.center.y);
    [self.view addSubview:_imgRight];
    
    _lblRight = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, _orginY, 60, NavigationBar_HEIGHT)];
    
    _lblRight.numberOfLines = 0;
    _lblRight.textAlignment=NSTextAlignmentCenter;
    _lblRight.font = [UIFont systemFontOfSize:14];
    _lblRight.textColor = [UIColor whiteColor];
    _lblRight.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_lblRight];
    
    _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, _orginY, 60, NavigationBar_HEIGHT)];
    _btnRight.backgroundColor = [UIColor clearColor];
    [_btnRight addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnRight];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.formerPopGestureRecognizerEnabled = self.navigationController.interactivePopGestureRecognizer.enabled;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.disableSlideBack && [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = self.formerPopGestureRecognizerEnabled;
    }
}

- (void)setBarTitle:(NSString *)strTitle
{
    _lblTitle.text = strTitle;
    NSLog(@"%@",_lblTitle);
}

- (void)setBarTitleColor:(UIColor *)color
{
    _lblTitle.textColor = color;
}

- (void)addLeftButton:(NSString *)strImage
{
    UIImage *imgBtn = [UIImage imageWithBundleName:strImage];
    _imgLeft.image = imgBtn;
    [_imgLeft setFrame:CGRectMake(_btnLeft.frame.origin.x + 10, _btnLeft.frame.origin.y, imgBtn.size.width , imgBtn.size.height )];
    _imgLeft.center = CGPointMake(_imgLeft.center.x, _lblTitle.center.y);
}

- (void)addRightButton:(NSString *)strImage
{
    UIImage *imgBtn = [UIImage imageWithBundleName:strImage];
    _imgRight.image = imgBtn;
    [_imgRight setFrame:CGRectMake(_btnRight.frame.origin.x + 25, _btnRight.frame.origin.y,imgBtn.size.width , imgBtn.size.height )];
    _imgRight.center = CGPointMake(_imgRight.center.x, _imgLeft.center.y);
}

-(void) adjustRightButtonPostionX:(NSInteger) aOffsetX
{
    if (_imgRight) {
        CGPoint point = _imgRight.center;
        point.x += aOffsetX;
        _imgRight.center = point;
    }
}

- (void)addLeftbuttontitle:(NSString *)strName
{
    _lblLeft.text=strName;
}
- (void)addRightbuttontitle:(NSString *)strName
{
    _lblRight.text=strName;
}


-(void)dealloc{
    
    NSLog(@"%@ === %@ is   Dealloc",self.title,[[self class] description]);
    
}

- (void)clickLeftButton:(UIButton *)sender
{
    NSLog(@"left button click");
    UIViewController *aa = [self.navigationController popViewControllerAnimated:NO];
   
    NSLog(@"弹出到上一页面:%@",aa);
}

- (void)clickRightButton:(UIButton *)sender
{
    NSLog(@"right button click");
}

- (void)addStarToNavigtionBar
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 0, 32 / 2.0, 45 / 2.0)];
    imageView.image = [UIImage imageWithBundleName:@"iconAffirmed.png"];
    imageView.center = CGPointMake(imageView.center.x, _imgLeft.center.y);
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    
    if (self.didMoveToParentViewControllerBlock) {
        self.didMoveToParentViewControllerBlock(self);
    }
}

@end

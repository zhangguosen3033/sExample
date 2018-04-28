//
//  NearbymerchantsDetailViewController.m
//  mall3658
//
//  Created by ygkj on 2017/9/5.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "NearbymerchantsDetailViewController.h"
#import "NearByDetailTableViewCell.h"
#import <SDCycleScrollView.h>
#import "PathPlanningViewController.h"

#import <MWPhotoBrowser.h>
@interface NearbymerchantsDetailViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,nearStorePhoneTableViewCellDelegate,AMapLocationManagerDelegate,MWPhotoBrowserDelegate,UIActionSheetDelegate>
{
    int page;//页数
    NSMutableDictionary * dataSouce;
    NSMutableArray *imageDataArray;
    
    BOOL isOpen;
    BOOL isOpenBottom;
}
@end

@implementation NearbymerchantsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblTitle.textColor = [UIColor whiteColor];
    _lblTitle.text = @"个人中心";
  _topView.backgroundColor = [Toolkit getColor:hex_1D85FF];
    imageDataArray =[[NSMutableArray alloc]init];
    
    _btnLeft.hidden =YES;
    self.view.backgroundColor=[Toolkit getColor:hex_f3f3f3];
    dataSouce=[NSMutableDictionary dictionary];

    
    [self.view insertSubview:self.customTableView belowSubview:_topView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.goToPay];
    
    //修正偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    self.infoDetial = @"项目主要包含2大基本模块，等下的让我想想怎么编。。。。。。。。。项目主要包含2大基本模块，等下的让我想想怎么编。。。。。。。。。项目主要包含2大基本模块，等下的让我想想怎么编。。。。。。。。。项目主要包含2大基本模块，等下的让我想想怎么编。。。。。。。。。";
    
    [self viewMakeMasConstraints];
    
    isOpen = NO;
    isOpenBottom =NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self checkIsLocationWithLoadMore:NO];//检测是否定位并加装数据
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

//!!!: delegate使用真实的protocol名称，按住cmd点击可以跳转protocol文件
#pragma mark - UITableViewDataSource UITableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifile=@"Cell";
    NearByDetailTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        cell=[[NearByDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifile];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor =[UIColor whiteColor];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        cell.titleLb.text =self.cityDetial;
        cell.starImage.hidden =NO;
        cell.mapImage.hidden =NO;
        cell.starImage.image =[UIImage imageNamed:@"商家详情电话@2x"];
        cell.mapImage.image =[UIImage imageNamed:@"商家详情地图@2x"];
        [cell.titleLb remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.mapImage.mas_right).offset(4*ratio_width);
            make.top.equalTo(cell.contentView).offset(13*ratio_width);
            make.right.equalTo(cell.contentView).offset(-45*ratio_width);
            make.bottom.equalTo(cell.contentView).offset(-10*ratio_width);
        }];
        cell.titleLb.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickgoToMapBtn)];
        [cell.titleLb addGestureRecognizer:tap];
        
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        cell.starImage.hidden =YES;
        cell.titleLb.text = @"基于iOS平台的移动客户端";
        
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        cell.starImage.hidden =YES;
        cell.titleLb.text = self.infoDetial;
    }
    cell.delegate = self;
    cell.index = indexPath;
    return cell;
}
//计算各个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //防止地址名称过长
        CGFloat heigth =  [self getFrame:[NSString stringWithFormat:@"%@",self.cityDetial]];
        if (heigth >90/2.0*ratio_width)
        {
            return heigth;
        }else{
            
            return 90/2.0*ratio_width;
        }
        
    }
 
    else if (indexPath.section ==2 && isOpenBottom )
    {
        
        CGFloat heigth = ([self getFrame:[NSString stringWithFormat:@"%@",self.infoDetial]]);
        if (heigth >120/2.0*ratio_width)
        {
            return heigth;
        }else{
            
            return 120/2.0*ratio_width;
        }
    }
    else
    {
        return 120/2.0*ratio_width;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0 ) {
        
        return 200*ratio_width;
        
    }else{
        return 45*ratio_width;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10*ratio_width;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10*ratio_width)];
    footer.backgroundColor =[Toolkit getColor:hex_f3f3f3];
    return footer;
}
//组头试图的信息
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200*ratio_width)];
        header.backgroundColor =[Toolkit getColor:hex_f3f3f3];
        
        
        SDCycleScrollView *banner=  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200*ratio_width)
                                                           imagesGroup:@[[UIImage imageNamed:@"轮播0.jpg"],[UIImage imageNamed:@"轮播1.jpg"]]];
        banner.autoScrollTimeInterval=5.0;
        //        banner.isFirstPage=YES;
        banner.isOpenImageScaleAspectFill =YES;//这里为了图片不变形
        banner.placeholderImage=[UIImage imageNamed:@"商城banner"];
        banner.showPageControl = YES;
        banner.dotColor =[Toolkit getColor:hex_1D85FF];
        [header addSubview:banner];
        
        
        [header addSubview:self.goToMap];
        [self.goToMap mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(header.mas_bottom).offset(-21);
            make.right.equalTo(header).offset(-15*ratio_width);
            make.height.width.equalTo(50*ratio_width);
        }];
        
        
        return header;
        
    }
    else if (section == 1)
    {
        UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45*ratio_width)];
        header.backgroundColor =[Toolkit getColor:hex_ffffff];
        
        UILabel *hederTitle = [UILabel new];
        hederTitle.text = @"项目类型:";
        hederTitle.textColor =[Toolkit getColor:hex_606060];
        hederTitle.font =[UIFont boldSystemFontOfSize:14];
        [header addSubview:hederTitle];
        [hederTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header.mas_top).offset(15*ratio_width);
            make.left.equalTo(header).offset(15*ratio_width);
            make.height.equalTo(15*ratio_width);
        }];
        
        UIView *lineView =[UIView new];
        [header addSubview:lineView];
        lineView.backgroundColor =[Toolkit getColor:hex_e5e5e5];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(header.mas_bottom);
            make.right.equalTo(header).offset(-15*ratio_width);
            make.left.equalTo(header).offset(15*ratio_width);
            make.height.equalTo(0.5);
        }];
        
        return header;
        
    }
    else if (section == 2)
    {
        UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45*ratio_width)];
        header.backgroundColor =[Toolkit getColor:hex_ffffff];
        header.userInteractionEnabled =YES;
        
        UILabel *hederTitle = [UILabel new];
        hederTitle.text = @"项目介绍";
        hederTitle.textColor =[Toolkit getColor:hex_282828];
        hederTitle.font =[UIFont boldSystemFontOfSize:15];
        [header addSubview:hederTitle];
        [hederTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header.mas_top).offset(15*ratio_width);
            make.left.equalTo(header).offset(15*ratio_width);
            make.height.equalTo(15*ratio_width);
        }];
        UIView *rightView =[UIView new];
        rightView.userInteractionEnabled =YES;
        UITapGestureRecognizer *rightViewTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickMoreInfoBottom)];
        [rightView addGestureRecognizer:rightViewTap];
        [header addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header.mas_top).offset(5*ratio_width);
            make.right.equalTo(header).offset(-6*ratio_width);
            make.height.width.equalTo(35*ratio_width);
        }];
        
        UIImageView *image = [UIImageView new];
        if (isOpenBottom)
        {
            image.image =[UIImage imageNamed:@"商家详情收起@2x"];
            
        }else
        {
            image.image =[UIImage imageNamed:@"商家详情下拉@2x"];
        }
        image.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickMoreInfoBottom)];
        [image addGestureRecognizer:tap];
        [header addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header.mas_top).offset(15*ratio_width);
            make.right.equalTo(header).offset(-11*ratio_width);
            make.height.width.equalTo(20*ratio_width);
        }];
        
        UIView *lineView =[UIView new];
        [header addSubview:lineView];
        lineView.backgroundColor =[Toolkit getColor:hex_e5e5e5];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(header.mas_bottom);
            make.right.equalTo(header).offset(-15*ratio_width);
            make.left.equalTo(header).offset(15*ratio_width);
            make.height.equalTo(0.5);
        }];
        
        return header;
        
        
    }
    else
    {
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -其他代理方法

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return imageDataArray.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    return [MWPhoto photoWithURL:[NSURL URLWithString:imageDataArray[index]]];
}
#pragma mark -弹框协议
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 111) {
        if (buttonIndex == 1) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
                //跳转到定位权限页面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }else {
                //跳转到定位开关界面
                NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
                if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }
    } else if (alertView.tag == 222) {
        if (buttonIndex == 1) {
            //跳转到定位权限页面
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
    
}
#pragma mark - 网络请求
//检测是否开始定位  再请求网络
-(void)checkIsLocationWithLoadMore:(BOOL)isLoadMore{
    
    //判断定位是否开启
    if ([CLLocationManager locationServicesEnabled])
    {
        //  判断用户是否允许程序获取位置权限
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways)
        {
            //用户允许获取位置权限
            //            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
            
            //获取到单次定位的结果
            [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
                
                if (error)
                {
                    //                        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                    
                    if (error.code == AMapLocationErrorLocateFailed)
                    {
                        return;
                    }
                }
                
                NSLog(@"location:%@", location);
                self.nowCity = regeocode.city;
                self.nowDetailCoordinate = location.coordinate;
                self.cityDetial =[NSString stringWithFormat:@"%@",regeocode.formattedAddress];
                [self.customTableView reloadData]; //获取到经纬度后刷新当前显示列表
                //                [self loadNewRequest:isLoadMore];
                
                if (regeocode)
                {
                    //                        NSLog(@"reGeocode:%@", regeocode);
                }
            }];
        }else
        {
            //用户拒绝开启用户权限
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"打开[定位服务权限]来允许[项目]确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            alertView.delegate=self;
            alertView.tag=222;
            [alertView show];
        }
    }
    else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"打开[定位服务]来允许[项目]确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>慧赚宝>始终)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        alertView.delegate=self;
        alertView.tag=111;
        [alertView show];
    }
    
}


#pragma mark  根据正文字数 调整高度
-(void)ClickMoreInfoBottom{
    
    isOpenBottom = !isOpenBottom;
    
    [self.customTableView reloadData];
}
//设置展开的时候的高度计算
-(CGFloat)getFrame:(NSString *)str{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:2.0f];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [str length])];
    CGSize realSize = CGSizeZero;
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 30*ratio_width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:style} context:nil];
    realSize = textRect.size;
    realSize.height = ceilf(realSize.height);
    
    return realSize.height +23*ratio_width;
    
}
#pragma mark -点击事件
//点击拨打电话
-(void)clickPhone:(NSIndexPath *)index{
    
        UIWebView * callWebview = [[UIWebView alloc]init];
        
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [NSString stringWithFormat:@"%@",@"18616743623"]]]]];
        [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}
-(void)clickgoToMapBtn{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"去厂区" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"松江厂区",@"昆山厂区",@"外高桥厂区", nil, nil];
    //actionSheet样式
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    //显示
    [sheet showInView:self.view];
    sheet.delegate = self;
  
}
//actionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
        {//东华
            PathPlanningViewController *pathPlane = [[PathPlanningViewController alloc]init];
            pathPlane.startCoordinate = self.nowDetailCoordinate;
            //    pathPlane.destinationCoordinate = self.nowDetailDestionCoordinate;
            pathPlane.destinationCoordinate = (CLLocationCoordinate2D){31.0571600000,121.2157400000};
            pathPlane.mapCity = self.nowCity;
            [self.navigationController pushViewController:pathPlane animated:YES];
        }
            break;
        case 1:
        {//昆山
            PathPlanningViewController *pathPlane = [[PathPlanningViewController alloc]init];
            pathPlane.startCoordinate = self.nowDetailCoordinate;
            pathPlane.destinationCoordinate = (CLLocationCoordinate2D){31.3016100000,121.0891200000};
            pathPlane.mapCity = self.nowCity;
            [self.navigationController pushViewController:pathPlane animated:YES];
        }
            break;
        case 2:
        {//外高桥
            PathPlanningViewController *pathPlane = [[PathPlanningViewController alloc]init];
            pathPlane.startCoordinate = self.nowDetailCoordinate;
            pathPlane.destinationCoordinate = (CLLocationCoordinate2D){31.3501500000,121.5893500000};
            pathPlane.mapCity = self.nowCity;
            [self.navigationController pushViewController:pathPlane animated:YES];
        }
            break;
        default:
            break;
    }

}

#pragma mark 初始化
-(UITableView*)customTableView
{
    if (!_customTableView) {
        _customTableView=[[TableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _customTableView.backgroundColor=[Toolkit getColor:hex_f3f3f3];
        _customTableView.delegate=self;
        _customTableView.dataSource=self;
        _customTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        
        [Toolkit setContentInsetAdjustmentBehaviorNever4ScrollView:_customTableView];
    }
    return _customTableView;
}
-(UIView*)bottomView
{
    if (!_bottomView) {
        _bottomView=[UIView new];
        _bottomView.backgroundColor =[Toolkit getColor:hex_ffffff];
    }
    return _bottomView;
}

-(UIButton *)goToMap{
    if (!_goToMap ) {
        _goToMap = [[UIButton alloc]init];
        [_goToMap setImage:[UIImage imageNamed:@"gps定位图标"] forState:UIControlStateNormal];
        [_goToMap addTarget:self action:@selector(clickgoToMapBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _goToMap;
}

#pragma mark 布局
-(void)viewMakeMasConstraints{
    
 
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabBar_HEIGHT);
    }];
    
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

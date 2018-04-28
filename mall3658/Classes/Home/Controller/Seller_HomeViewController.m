//
//  Seller_HomeViewController.m
//  mall3658
//
//  Created by lz on 16/6/12.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "Seller_HomeViewController.h"
#import <SDCycleScrollView.h>
#import "NearbymerchantsTableViewCell.h"
#import "LineChartViewController.h"
#import "NearbymerchantsViewController.h"

@interface Seller_HomeViewController ()<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>


@end

@implementation Seller_HomeViewController{
 
}

#pragma mark - vc_life_cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    _topView.backgroundColor = [Toolkit getColor:hex_1D85FF];
    self.view.backgroundColor=[Toolkit getColor:hex_f3f3f3];
    _lblTitle.text =@"数据助手";
    _lblTitle.textColor = [UIColor whiteColor];
    [_btnLeft setBackgroundImage:nil forState:UIControlStateNormal];
    
    [self.view addSubview:self.runningMaLight];
    [self.view addSubview:self.customTableView];

#pragma mark ###4，进行界面布局
    //给view添加autolayout constraints
    [self viewMakeMasConstraints];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_app_ hiddenTabBar];
    [self.runningMaLight setMessage:@"暂无预警信息 IP正常 监控正常 "];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
//关闭
    [_runningMaLight closeRunLight];
    [SVProgressHUD dismiss];
    
}

//!!!: delegate使用真实的protocol名称，按住cmd点击可以跳转protocol文件
#pragma mark - UITableViewDataSource UITableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifile=@"Cell";
    NearbymerchantsTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        cell=[[NearbymerchantsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifile];
        
    }
    if (indexPath.row !=6) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            {
                cell.storeImage.image = [UIImage imageNamed:@"温度"];
                cell.titleLb.text =@"当前温度";
                cell.smallTitleLb.text = @"喷嘴:160℃  第一段:200℃ ...";
            }
            break;
        case 1:
        {
            cell.storeImage.image = [UIImage imageNamed:@"原材料2"];
            cell.titleLb.text =@"原料名称";
            cell.smallTitleLb.text = @"PS SAN(AS) ABS CA";
        }
            break;
        case 2:
        {
            cell.storeImage.image = [UIImage imageNamed:@"警告图标2"];
            cell.titleLb.text =@"警告";
            cell.smallTitleLb.text = @"暂无预警信息";
        }
            break;
        case 3:
        {
            cell.storeImage.image = [UIImage imageNamed:@"网络服务器2"];
            cell.titleLb.text =@"监控";
            cell.smallTitleLb.text = @"正常";
        }
            break;
        case 4:
        {

            cell.storeImage.image = [UIImage imageNamed:@"数据库图标"];
            cell.titleLb.text =@"IP数据";
            cell.smallTitleLb.text = @"正常";
        }
            break;
        case 5:
        {
            cell.storeImage.image = [UIImage imageNamed:@"确认图标2"];
            cell.titleLb.text =@"厂区编号";
            cell.smallTitleLb.text = @"001";
        }
            break;
        case 6:
        {
            cell.storeImage.image = [UIImage imageNamed:@"定时或时间图标"];
            cell.titleLb.text =@"同步服务器间隔设置";
            cell.smallTitleLb.text = @"正常";
        }
            break;
        default:
            break;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10*ratio_width)];
    header.backgroundColor =[Toolkit getColor:hex_f3f3f3];
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择查看对应温度统计" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"喷嘴温度",@"第一段温度",@"第二段温度",@"下料温度", nil, nil];
            //actionSheet样式
            sheet.actionSheetStyle = UIActionSheetStyleDefault;
            //显示
            [sheet showInView:self.view];
            sheet.delegate = self;
            
        }
            break;
        case 1:
        {
            NearbymerchantsViewController *yuanliaoVc =[[NearbymerchantsViewController alloc]init];
            yuanliaoVc.titleStr = @"厂区原料列表";
            yuanliaoVc.typeNum = 1;
            [self.navigationController pushViewController:yuanliaoVc animated:YES];
        }
            break;
        case 2:
        {
            NearbymerchantsViewController *yuanliaoVc =[[NearbymerchantsViewController alloc]init];
            yuanliaoVc.titleStr = @"警告记录列表";
            yuanliaoVc.typeNum = 2;
            [self.navigationController pushViewController:yuanliaoVc animated:YES];
        }
            break;
        case 3:
        {
            NearbymerchantsViewController *yuanliaoVc =[[NearbymerchantsViewController alloc]init];
            yuanliaoVc.titleStr = @"监控记录列表";
            yuanliaoVc.typeNum = 3;
            [self.navigationController pushViewController:yuanliaoVc animated:YES];
        }
            break;
        case 4:
        {
            NearbymerchantsViewController *yuanliaoVc =[[NearbymerchantsViewController alloc]init];
            yuanliaoVc.titleStr = @"IP异常记录列表";
            yuanliaoVc.typeNum = 4;
            [self.navigationController pushViewController:yuanliaoVc animated:YES];
        }
            break;
        case 5:
        {
            NearbymerchantsViewController *yuanliaoVc =[[NearbymerchantsViewController alloc]init];
            yuanliaoVc.titleStr = @"厂区编号列表";
            yuanliaoVc.typeNum = 5;
            [self.navigationController pushViewController:yuanliaoVc animated:YES];
        }
            break;
        case 6:
        {
  
        }
            break;
        default:
            break;
    }
    
}



//actionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
        {//喷嘴温度
            LineChartViewController *chartVC =[[LineChartViewController alloc]init];
            chartVC.titleStr = @"喷嘴温度统计";
            chartVC.sevenDic = @{@"date":@[@"4/24",@"4/25",@"4/26",@"4/27",@"4/28",@"4/29",@"4/30"],
                                 @"abscissa":@[@"160",@"190",@"160",@"210",@"170",@"180",@"160"],
                                 @"vertical_coordinate":@[@"150",@"160",@"170",@"180",@"190",@"200",@"210"],
                                 };
            chartVC.thirtyDic = @{@"date":@[@"4/1",@"4/5",@"4/10",@"4/15",@"4/20",@"4/25",@"4/30"],
                                  @"abscissa":@[@"168",@"180",@"170",@"200",@"175",@"180",@"170"],
                                  @"vertical_coordinate":@[@"150",@"160",@"170",@"180",@"190",@"200",@"210"],
                                  };
            [self.navigationController pushViewController:chartVC animated:YES];
        }
            break;
        case 1:
        {//第一段温度
            LineChartViewController *chartVC =[[LineChartViewController alloc]init];
            chartVC.titleStr = @"第一段温度统计";
            chartVC.sevenDic = @{@"date":@[@"4/24",@"4/25",@"4/26",@"4/27",@"4/28",@"4/29",@"4/30"],
                                 @"abscissa":@[@"160",@"190",@"160",@"210",@"170",@"180",@"160"],
                                 @"vertical_coordinate":@[@"150",@"160",@"170",@"180",@"190",@"200",@"210"],
                                 };
            chartVC.thirtyDic = @{@"date":@[@"4/1",@"4/5",@"4/10",@"4/15",@"4/20",@"4/25",@"4/30"],
                                  @"abscissa":@[@"168",@"180",@"170",@"200",@"175",@"180",@"170"],
                                  @"vertical_coordinate":@[@"150",@"160",@"170",@"180",@"190",@"200",@"210"],
                                  };
            [self.navigationController pushViewController:chartVC animated:YES];
        }
            break;
        case 2:
        {//第二段温度
            LineChartViewController *chartVC =[[LineChartViewController alloc]init];
            chartVC.titleStr = @"第二段温度统计";
            chartVC.sevenDic = @{@"date":@[@"4/24",@"4/25",@"4/26",@"4/27",@"4/28",@"4/29",@"4/30"],
                                 @"abscissa":@[@"160",@"190",@"160",@"210",@"170",@"180",@"160"],
                                 @"vertical_coordinate":@[@"150",@"160",@"170",@"180",@"190",@"200",@"210"],
                                 };
            chartVC.thirtyDic = @{@"date":@[@"4/1",@"4/5",@"4/10",@"4/15",@"4/20",@"4/25",@"4/30"],
                                  @"abscissa":@[@"168",@"180",@"170",@"200",@"175",@"180",@"170"],
                                  @"vertical_coordinate":@[@"150",@"160",@"170",@"180",@"190",@"200",@"210"],
                                  };
            [self.navigationController pushViewController:chartVC animated:YES];
        }
            break;
        case 3:
        {//下料温度
            LineChartViewController *chartVC =[[LineChartViewController alloc]init];
            chartVC.titleStr = @"下料温度统计";
            chartVC.sevenDic = @{@"date":@[@"4/24",@"4/25",@"4/26",@"4/27",@"4/28",@"4/29",@"4/30"],
                                 @"abscissa":@[@"160",@"190",@"160",@"210",@"170",@"180",@"160"],
                                 @"vertical_coordinate":@[@"150",@"160",@"170",@"180",@"190",@"200",@"210"],
                                 };
            chartVC.thirtyDic = @{@"date":@[@"4/1",@"4/5",@"4/10",@"4/15",@"4/20",@"4/25",@"4/30"],
                                  @"abscissa":@[@"168",@"180",@"170",@"200",@"175",@"180",@"170"],
                                  @"vertical_coordinate":@[@"150",@"160",@"170",@"180",@"190",@"200",@"210"],
                                  };
            [self.navigationController pushViewController:chartVC animated:YES];
        }
            break;
        default:
            break;
    }
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
#pragma mark -网络请求
//-(void)requestDataSource
//{
//    NSMutableDictionary * dict=[NSMutableDictionary new];
//    [dict setObject:@"Freecard.Rulelist" forKey:@"service"];
//    [[Mall_APIManager sharedManager]request_Freecard_RulelistWithParams:dict andBlock:^(id data, NSError *error) {
//        NSLog(@"%@",data);
//        NSNumber * ret=[data objectForKey:@"ret"];
//        if ([ret isEqualToNumber:kRequestSuccess]) {
//            NSDictionary * dataDic=[[data objectForKey:@"data"] objectForKey:@"content"];
//            [runArr removeAllObjects];
//            xieyiStr=dataDic[@"wap_xieyi"];
//            msgStr=dataDic[@"wap_url"];
//            if (![dataDic[@"roll"] isKindOfClass:[NSNull class]]) {
//                runArr=[YSRunLightModel objectArrayWithKeyValuesArray:dataDic[@"roll"]];
//
//                for (YSRunLightModel * model in runArr) {
//                    NSLog(@"%@",model.msg);
//                    NSString *tempMessage = [model.msg stringByAppendingString:@"          "];
//                    messageString = [NSMutableString stringWithFormat:@"%@", [messageString stringByAppendingString:tempMessage]];
//                }
//                NSLog(@"%@",messageString);
//                [self.runningMaLight setMessage:messageString];
//            }
//            if (![dataDic[@"package_info"] isKindOfClass:[NSNull class]]) {
//                dataArray=[YSFreeShoppingCardModel objectArrayWithKeyValuesArray:dataDic[@"package_info"]];
//
//                [self.customTableView reloadData];
//                [self updataSource];
//            }
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:[data objectForKey:@"msg"]];
//
//        }
//    }];
//
//}
#pragma mark -懒加载
-(GSRunningMaLight*)runningMaLight
{
    if (!_runningMaLight) {
        _runningMaLight=[[GSRunningMaLight alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 32)];
    }
    return _runningMaLight;
}
-(UITableView*)customTableView
{
    if (!_customTableView) {
        _customTableView=[[TableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _customTableView.backgroundColor=[Toolkit getColor:hex_f3f3f3];
        _customTableView.delegate=self;
        _customTableView.dataSource=self;
        _customTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        
//        _customTableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        }];
//        _customTableView.footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        }];
    }
    
    return _customTableView;
}
/**
 *  给vc中的view添加autolayout constraints
 */

-(void)viewMakeMasConstraints{
    
    [self.runningMaLight makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.bottom).offset(0);
        make.right.left.equalTo(self.view).offset(0);
        make.height.equalTo(@32);
    }];

    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.runningMaLight.bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabBar_HEIGHT);
    }];
    
}

#pragma mark-----------修改ScrollView的尺寸------------
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end



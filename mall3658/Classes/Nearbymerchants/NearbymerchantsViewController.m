//
//  NearbymerchantsViewController.m
//  mall3658
//
//  Created by ygkj on 2017/9/5.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "NearbymerchantsViewController.h"
#import "FreeShareSettlementTableViewCell.h"

@interface NearbymerchantsViewController ()<UITableViewDelegate,UITableViewDataSource>

{
 
    
}
@end

@implementation NearbymerchantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lblTitle.textColor = [UIColor whiteColor];
    _topView.backgroundColor = [Toolkit getColor:hex_1D85FF];
    self.view.backgroundColor=[Toolkit getColor:hex_f3f3f3];
    _lblTitle.text =self.titleStr;
    [self.view addSubview:self.customTableView];


    [self viewMakeMasConstraints];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
 
}


//!!!: delegate使用真实的protocol名称，按住cmd点击可以跳转protocol文件
#pragma mark - UITableViewDataSource UITableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.typeNum == 1 || self.typeNum ==5) { //如果是原料列表和厂区编号不显示组透视图
        return 1;
    }
    else if (self.typeNum == 4 || self.typeNum == 3)
    {
        return 1;
    }
    else{
        return arc4random() % 3 +1;
        
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.typeNum == 1 || self.typeNum ==5)
    { //如果是原料列表和厂区编号不显示组透视图
        return 3;
    }
    else{
        
        return self.typeNum;//随便给一个组数
        
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifile=@"Cell";
    FreeShareSettlementTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        cell=[[FreeShareSettlementTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifile];
        
    }
    switch (self.typeNum) {
        case 1:
            {
                cell.titleLb.text = [NSString stringWithFormat:@"00%ld_号厂区%u号车间",indexPath.section+1,arc4random() % 2 +1];
                cell.descLb.text = @"聚苯乙烯(PS) _苯乙烯-丙烯腈(SAN) 丙烯腈-丁二烯-苯乙烯(ABS) 醋酸纤维素(CA)";
                cell.timeLb.text =[NSString stringWithFormat:@"2018/3/%u",arc4random() % 30 +1];

            }
            break;
        case 2:
        {
            cell.titleLb.text = @"警告信息";
            cell.descLb.text =[NSString stringWithFormat:@"原因：由样机编号000bxSYS%u号引发的警告信息",arc4random() % 100 +1];
            cell.timeLb.text =[NSString stringWithFormat:@"2018/%ld/15",indexPath.section+2];

        }
            break;
        case 3:
        {
            cell.titleLb.text = @"暂无监控异常";
            cell.descLb.text =@"监控运行正常未发现异常监控信息";
            cell.timeLb.text =[NSString stringWithFormat:@"2018/%ld/15",indexPath.section+2];
        }
            break;
        case 4:
        {
            cell.titleLb.text = @"暂无IP异常";
            cell.descLb.text =@"运行情况正常暂无IP异常信息";
            cell.timeLb.text =[NSString stringWithFormat:@"2018/%ld/15",indexPath.section+2];
        }
            break;
        case 5:
        {
            switch (indexPath.section) {
                case 0:
                {
                    cell.titleLb.text = @"001_松江厂区";
                    cell.timeLb.text =@"添加时间：2018/1/5";
                    cell.descLb.text = @"标准化样本厂区，用来进行数据信息采集和样本监控观察";
                }
                    break;
                case 1:
                {
                    cell.titleLb.text = @"002_昆山厂区";
                    cell.timeLb.text =@"添加时间：2018/1/20";
                    cell.descLb.text = @"标准化样本厂区，用来进行数据信息采集和样本监控观察";
                }
                    break;
                case 2:
                {
                    cell.titleLb.text = @"003_外高桥厂区";
                    cell.timeLb.text =@"添加时间：2018/1/20";
                    cell.descLb.text = @"标准化样本厂区，用来进行数据信息采集和样本监控观察";
                }
                    break;
                    
                default:
                    break;
            }

        }
            break;
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.typeNum == 1 || self.typeNum ==5) { //如果是原料列表和厂区编号不显示组透视图
        return 0.001;
    }else{
        return 30;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.typeNum == 1 || self.typeNum ==5) {
        return 10;
    }else{
        return 0.001;

    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.typeNum == 1 || self.typeNum ==5) { //如果是原料列表和厂区编号不显示组透视图
        return nil;
    }else{
        UIView *footer =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10*ratio_width)];
        footer.backgroundColor =[Toolkit getColor:hex_f3f3f3];
        
        UILabel *footeLb =[[UILabel alloc]initWithFrame:CGRectMake(15, 7, 100, 15)];
        footeLb.text =[NSString stringWithFormat:@"%ld月",section+2];
        [footer addSubview:footeLb];
        return footer;
    }
 
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10*ratio_width)];
    footer.backgroundColor =[Toolkit getColor:hex_f3f3f3];
    return footer;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
}
#pragma mark - UITableViewDelegate UITableView代理方法




#pragma mark ###4，进行界面布局：由上向下或者由下向上进行布局

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
    
 
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
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

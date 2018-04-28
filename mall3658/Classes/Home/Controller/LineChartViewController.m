//
//  LineChartViewController.m
//  mall3658
//
//  Created by ygkj on 2017/9/11.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "LineChartViewController.h"
#import "AAChartView.h"
@interface LineChartViewController ()
{
    NSMutableArray *lineRequestDataArray;
}

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _lblTitle.textColor = [UIColor whiteColor];
    _topView.backgroundColor =[Toolkit getColor:hex_1D85FF];
    self.view.backgroundColor =[Toolkit getColor:hex_f3f3f3];
    lineRequestDataArray =[[NSMutableArray alloc]init];
    [self.view addSubview:self.sevenLbel];
    [self.view addSubview:self.thirtyLbel];
    [self.view addSubview:self.sevenView];
    [self.view addSubview:self.thirtyView];

    [self viewMakeMasConstraints];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _lblTitle.text =self.titleStr;
    self.sevenLbel.text = [NSString stringWithFormat:@"最近7天%@",self.titleStr];
    self.thirtyLbel.text =[NSString stringWithFormat:@"最近30天%@",self.titleStr];
//    [self loadLineData];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
    [self creatSevenViewWithData:self.sevenDic];
    [self creatThirtyViewWithData:self.thirtyDic];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
-(void)creatSevenViewWithData:(NSDictionary *)dataDic{
    
    AAChartView *chartView = [[AAChartView alloc]init];
    
    chartView.scrollView.scrollEnabled = YES;
    
    chartView.scrollView.showsVerticalScrollIndicator = NO;
    chartView.scrollView.showsHorizontalScrollIndicator = NO;
    
    chartView.frame = CGRectMake(-10, 0, self.view.frame.size.width -30*ratio_width + 10, 390/2.0*ratio_width);
    
    [self.sevenView addSubview:chartView];

    AAChartModel *chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)//设置图表的类型
    
    .titleSet(@"7日统计")//设置图表标题
    //    .subtitleSet(@"副标题")//设置图表副标题
    .categoriesSet([dataDic objectForKey:@"date"])//设置图表横轴的内容
        .yAxisTitleSet(@"℃")//设置图表 y 轴的单位
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"温度")
                 .dataSet([self exchangeMethod:[dataDic objectForKey:@"abscissa"]]),
                 ])
    .yTickPositionsSet([self exchangeMethod:[dataDic objectForKey:@"vertical_coordinate"]]) //设置Y轴显示 金额
    .pointHollowSet(true)
    ;
    
    /*图表视图对象调用图表模型对象,绘制最终图形*/
    [chartView aa_drawChartWithChartModel:chartModel];

}
-(void)creatThirtyViewWithData:(NSDictionary *)dataDic{
    
    AAChartView *chartView = [[AAChartView alloc]init];
    
    chartView.scrollView.scrollEnabled = YES;
    
    chartView.scrollView.showsVerticalScrollIndicator = NO;
    chartView.scrollView.showsHorizontalScrollIndicator = NO;
    
    chartView.frame = CGRectMake(-10, 0, self.view.frame.size.width -30*ratio_width + 10, 390/2.0*ratio_width);
    [self.thirtyView addSubview:chartView];
    
    AAChartModel *chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)//设置图表的类型
    .titleSet(@"30日平均统计")//设置图表标题
    //    .subtitleSet(@"副标题")//设置图表副标题
    .categoriesSet([dataDic objectForKey:@"date"])//设置图表横轴的内容
    .yAxisTitleSet(@"℃")//设置图表 y 轴的单位
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"温度")
                 .dataSet([self exchangeMethod:[dataDic objectForKey:@"abscissa"]]),
                 ])
    .yTickPositionsSet([self exchangeMethod:[dataDic objectForKey:@"vertical_coordinate"]]) //设置Y轴显示 金额
    .pointHollowSet(true)
    ;
    
    /*图表视图对象调用图表模型对象,绘制最终图形*/
    [chartView aa_drawChartWithChartModel:chartModel];

}
//把后台返回的数组内的字符串转化为 数字类型 字符串表格不能识别
-(NSMutableArray *)exchangeMethod:(NSArray*)array{
    
    NSMutableArray *temptArray =[[NSMutableArray alloc]init];
    for (int i= 0; i <array.count; i++) {
        double conversionValue = [[[NSString stringWithFormat:@"%@",array[i]]stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
        NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
        NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
        [temptArray addObject:decNumber];
    }
    return temptArray;
}
#pragma mark -网络请求
-(void)loadLineData{
  
}

#pragma mark 基本控件初始化
-(UIView *)sevenView
{
    if (!_sevenView)
    {
        _sevenView = [UIView new];
        _sevenView.backgroundColor = [UIColor whiteColor];
        _sevenView.clipsToBounds = YES;
        _sevenView.layer.cornerRadius = 5.0;
        _sevenView.userInteractionEnabled =YES;
    }
    return _sevenView;
}
-(UIView *)thirtyView
{
    if (!_thirtyView)
    {
        _thirtyView = [UIView new];
        _thirtyView.backgroundColor = [UIColor whiteColor];
        _thirtyView.clipsToBounds = YES;
        _thirtyView.layer.cornerRadius = 5.0;
        _thirtyView.userInteractionEnabled =YES;
    }
    return _thirtyView;
}
-(UILabel*)sevenLbel
{
    if (!_sevenLbel) {
        _sevenLbel=[UILabel new];
        _sevenLbel.text = @"最近7天";
        _sevenLbel.textAlignment = NSTextAlignmentLeft;
        _sevenLbel.font = [UIFont systemFontOfSize:15];
        _sevenLbel.textColor = [Toolkit getColor:@"ffffff"];
        _sevenLbel.clipsToBounds = YES;
        _sevenLbel.layer.cornerRadius = 5.0;
        _sevenLbel.backgroundColor = [Toolkit getColor:@"ff8b00"];
    }
    return _sevenLbel;
}
-(UILabel*)thirtyLbel
{
    if (!_thirtyLbel) {
        _thirtyLbel=[UILabel new];
        _thirtyLbel.text = @"最近30天";
        _thirtyLbel.textAlignment = NSTextAlignmentLeft;
        _thirtyLbel.font = [UIFont systemFontOfSize:15];
        _thirtyLbel.textColor = [Toolkit getColor:@"ffffff"];
        _thirtyLbel.backgroundColor = [Toolkit getColor:@"ff8b00"];
        _thirtyLbel.clipsToBounds = YES;
        _thirtyLbel.layer.cornerRadius = 5.0;
    }
    return _thirtyLbel;
}

#pragma mark -界面的布局
-(void)viewMakeMasConstraints{
    
    [self.sevenLbel makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(_topView.mas_bottom).offset(15*ratio_width);
        make.left.equalTo(self.view).offset(15*ratio_width);
        make.right.equalTo(self.view).offset( -15*ratio_width);
        make.height.equalTo(41*ratio_width);
    }];
    [self.sevenView makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(self.sevenLbel.mas_bottom).offset(15*ratio_width);
        make.left.equalTo(self.view).offset(15*ratio_width);
        make.right.equalTo(self.view).offset( -15*ratio_width);
        make.height.equalTo(390/2.0*ratio_width);
    }];
    [self.thirtyLbel makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(self.sevenView.mas_bottom).offset(25*ratio_width);
        make.left.equalTo(self.view).offset(15*ratio_width);
        make.right.equalTo(self.view).offset( -15*ratio_width);
        make.height.equalTo(41*ratio_width);
    }];
    [self.thirtyView makeConstraints:^(MASConstraintMaker* make){
        make.top.equalTo(self.thirtyLbel.mas_bottom).offset(15*ratio_width);
        make.left.equalTo(self.view).offset(15*ratio_width);
        make.right.equalTo(self.view).offset( -15*ratio_width);
        make.height.equalTo(390/2.0*ratio_width);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

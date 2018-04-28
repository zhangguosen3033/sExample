//
//  RecommendAwardsControl.m
//  mall3658
//
//  Created by Yangsu on 16/3/2.
//  Copyright © 2016年 Leo. All rights reserved.
//  推荐奖励页面

#import "RecommendAwardsControl.h"
#import "CustomCollectionViewCell.h"
#import "CustomTableViewCell.h"
#import <Masonry/Masonry.h>
#import "Mall_APIClient.h"
#import "MyTuiGuangViewController.h"
#import "UserState.h"
#import "User.h"
#define collectViewHeight 140
#define collectcellW 150
#define bottomViewH self.Bottomview.frame.size.height
#define identifyID @"CollectionCell"
#define TableCellId @"TableCell"
#define CustomCellId @"CustomCell"
//#define OldFrame self.view.frame
@interface RecommendAwardsControl ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation RecommendAwardsControl
{
    NSArray * _arr;
    UILabel * Recommdlabel;
    UIView * Recommedrview;
    UIButton * Withdrawals;
    UIView * WithdrawalsView;
    BOOL isWithDrawals;
    UITextField * Withfield;
    
    NSDictionary * WithdrawalInfo;
    NSString * pwdString;
    NSString * string;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CustomNavigation];
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)CustomNavigation
{
    _lblTitle.text=@"推荐奖励";
    _lblTitle.textColor=[UIColor whiteColor];
    _topView.backgroundColor=[Toolkit getColor:hex_red_color];
    

}
/***
 推荐奖励页面搭建
 */
-(void)createUI
{
    isWithDrawals=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [_app_ hiddenTabBar];
    _arr=@[@"推荐积分",@"活跃度"];
    self.view.backgroundColor = [Toolkit getColor:hex_f3f3f3];
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
   
    
    self.collection.showsVerticalScrollIndicator=NO;
    self.collection=[[UICollectionView alloc]initWithFrame:CGRectMake(5, 70, (SCREEN_WIDTH-10), collectViewHeight) collectionViewLayout:flowLayout];
    self.collection.backgroundColor=[UIColor whiteColor];
    //flowLayout.itemSize=CGSizeMake(collectcellH,150);
    self.collection.userInteractionEnabled=NO;
    self.collection.delegate=self;
    self.collection.dataSource=self;
    [self.view addSubview:self.collection];
    [self.collection registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifyID];
    
    self.Bottomview=[[UIView alloc]init];
    self.Bottomview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.Bottomview];
    
    Recommedrview=[[UIView alloc]init];
    Recommedrview.backgroundColor=[UIColor whiteColor];
    [self.Bottomview addSubview:Recommedrview];
    //显示推荐
    UILabel * minlable=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-60, 50)];
    minlable.text=@"推荐好友注册，您将获得推荐奖励";
    minlable.textAlignment=NSTextAlignmentLeft;
    minlable.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
    Recommedrview.userInteractionEnabled=YES;
    [Recommedrview addSubview:minlable];
    
    //点击手势
    UITapGestureRecognizer * tapGestur=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushMyextension)];
    tapGestur.numberOfTapsRequired=1;
    tapGestur.numberOfTouchesRequired=1;
    [Recommedrview addGestureRecognizer:tapGestur];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,60, SCREEN_WIDTH,200)];
    self.tableView.userInteractionEnabled=NO;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.Bottomview addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CustomCellId];
    //self.tableView.tableHeaderView=Recommedrview;
    
    //转现按钮
    Withdrawals=[UIButton buttonWithType:UIButtonTypeCustom];
    Withdrawals.backgroundColor=[UIColor redColor];
    [Withdrawals setTitle:@"转现红金宝" forState:UIControlStateNormal];
    [Withdrawals addTarget:self action:@selector(WithdrawalsClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.Bottomview addSubview:Withdrawals];
    //构建转现界面
    //[self createWithdrawalsView];
    //确定每个控件的坐标
    [self MakeManoryFrame];
    
    //点击不是兑换页面的地方关闭兑换页
//    UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CanCelWithdrawalsView)];
//    tapGesture.numberOfTapsRequired=1;
//    tapGesture.numberOfTouchesRequired=1;
//    [WithdrawalsView addGestureRecognizer:tapGesture];
}
/**
 *
 转换积分界面搭建
 */

-(void)createWithdrawalsView
{
    __weak typeof(id)superView=self.view;
    WithdrawalsView=[[UIView alloc]init];
    UIColor * mycolor=[UIColor colorWithWhite:0.2 alpha:1];
    WithdrawalsView.backgroundColor=mycolor;
    WithdrawalsView.userInteractionEnabled=YES;
    WithdrawalsView.alpha=1;
    [self.view addSubview:WithdrawalsView];
    
    [WithdrawalsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(0);
        make.right.equalTo(superView).offset(0);
        make.height.equalTo(@(SCREEN_HEIGHT/2));
        make.bottom.equalTo(superView).offset(0);
    }];
    
    
    UIButton * cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //[cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setImage:[UIImage imageNamed:@"关闭@2x"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(CancelWithdrawalsView:) forControlEvents:UIControlEventTouchUpInside];
    [WithdrawalsView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(WithdrawalsView).offset(0);
        make.top.equalTo(WithdrawalsView).offset(10);
        make.width.equalTo(@60);
        make.left.equalTo(WithdrawalsView).offset(SCREEN_WIDTH-60);
    }];
    
    //
    UILabel * Withlabel=[[UILabel alloc]init];
    Withlabel.text=@"转现积分";
    Withlabel.textAlignment=NSTextAlignmentCenter;
    Withlabel.font=[UIFont fontWithName:@"Heiti SC" size:14];
    [WithdrawalsView addSubview:Withlabel];
    
    [Withlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(WithdrawalsView).offset(30);
        make.top.equalTo(WithdrawalsView).offset(60);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
        
    }];
    
    
    Withfield=[[UITextField alloc]init];
    Withfield.placeholder=@"请输入转换积分";
    Withfield.tag=102;
    Withfield.text=@"";
    Withfield.delegate=self;
    Withfield.backgroundColor=[UIColor whiteColor];
    
    Withfield.borderStyle=UITextFieldViewModeWhileEditing;
    [WithdrawalsView addSubview:Withfield];
    
    [Withfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Withlabel).offset(80);
        make.top.equalTo(WithdrawalsView).offset(60);
        make.right.equalTo(WithdrawalsView).offset(-30);
        make.height.equalTo(Withlabel.height);
        
    }];
    
    
    UILabel * MessageLabel1=[[UILabel alloc]init];
    MessageLabel1.textAlignment=NSTextAlignmentLeft;
    MessageLabel1.text=@"温馨提示:";
    MessageLabel1.font=[UIFont fontWithName:@"Heiti SC" size:16];
    [WithdrawalsView addSubview:MessageLabel1];
    
    [MessageLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(WithdrawalsView).offset(30);
        make.top.equalTo(Withlabel).offset(80);
        make.right.equalTo(WithdrawalsView).offset(-30);
        make.height.equalTo(@40);
    }];
    
    UILabel * MessageLabel2=[[UILabel alloc]init];
    MessageLabel2.textAlignment=NSTextAlignmentLeft;
    MessageLabel2.text=@"积分转现红金宝需要和积分等数量的活跃度";
    MessageLabel2.font=[UIFont fontWithName:@"Heiti SC" size:16];
    [WithdrawalsView addSubview:MessageLabel2];
    
    [MessageLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(WithdrawalsView).offset(30);
        make.top.equalTo(MessageLabel1).offset(30);
        make.right.equalTo(WithdrawalsView).offset(-30);
        make.height.equalTo(@40);
    }];
    
    UIButton * SureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [SureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [SureBtn setBackgroundColor:[UIColor redColor]];
    [SureBtn addTarget:self action:@selector(MakeWithdrawal:) forControlEvents:UIControlEventTouchUpInside];
    [WithdrawalsView addSubview:SureBtn];
    
    [SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(WithdrawalsView).offset(30);
        make.top.equalTo(MessageLabel2).offset(80);
        make.right.equalTo(WithdrawalsView).offset(-30);
        make.height.equalTo(@40);
    }];
    
}
#pragma mark-------UICollectionDelegate-------------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifyID forIndexPath:indexPath];
    cell.textLable.text=_arr[indexPath.item];
    if (indexPath.item==0) {
        cell.cordLabel.text=WithdrawalInfo[@"recommend_integral"];
    }
    else
    {
        cell.cordLabel.text=WithdrawalInfo[@"activity_top"];
    }
    return cell;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectcellW, collectViewHeight);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,10, 5, 10);
}
#pragma mark---------UITableViewDelegate---------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:TableCellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableCellId];
        }
        cell.selected=NO;
        cell.textLabel.text=@"奖励形式如下:";
        return cell;
    }
    else
    {
        CustomTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:CustomCellId];
//        cell.label1.text=@"1.好友注册，你可以获得1000推荐积分";
//        cell.label2.text=@"2.推荐好友充值，你可以获得充值额0.5％的等值活跃度";
//        cell.label3.text=@"3.1推荐积分＋1活跃度可以转现1红金宝";
        NSArray * strArr=[string componentsSeparatedByString:@"\r\n"];
        cell.label1.text=[NSString stringWithFormat:@"1.%@",strArr[0]];
        cell.label2.text=[NSString stringWithFormat:@"2.%@",strArr[1]];
        cell.label3.text=[NSString stringWithFormat:@"3.%@",strArr[2]];
        cell.selected=NO;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 40;
    }
    else
    {
        return 150;
    
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
/**
 *
 确定推荐页面控件坐标
 */
-(void)MakeManoryFrame
{
    __weak typeof(id)superView=self.view;
    //下面的view
    [self.Bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(0);
        make.top.equalTo(@220);
        make.right.equalTo(superView).offset(0);
        make.bottom.equalTo(superView).offset(0);
    }];
    //头视图view
    [Recommedrview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(0);
        make.right.equalTo(superView).offset(0);
        make.top.equalTo(self.Bottomview).offset(0);
        make.height.equalTo(@50);
    }];
    
    
    
    [Withdrawals mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(20);
        make.right.equalTo(superView).offset(-20);
        make.height.equalTo(@50);
        make.bottom.equalTo(superView).offset(-50);
    }];

   
}
/***
 跳转兑换页面
 */
-(void)WithdrawalsClick:(UIButton*)button
{
    isWithDrawals=YES;
    [self createWithdrawalsView];
    
    
}
/***
 跳转我的推广页面
 */
-(void)pushMyextension
{
    if (!isWithDrawals) {
        MyTuiGuangViewController * Myextension=[[MyTuiGuangViewController alloc]init];
        [self.navigationController pushViewController:Myextension animated:YES];
    }
    
}
/***
 实现兑换奖励
 */
-(void)MakeWithdrawal:(UIButton*)button
{
    [Withfield resignFirstResponder];
    if (Withfield.text.length<1||([Withfield.text doubleValue]>[WithdrawalInfo[@"recommend_integral"] doubleValue])||[Withfield.text doubleValue]==0) {
        UIAlertController * alter=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入积分或积分不足，推荐好友赢积分！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alterAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alter addAction:alterAction];
        [self presentViewController:alter animated:YES completion:nil];
    }else if([Withfield.text integerValue]>[WithdrawalInfo[@"activity_top"] integerValue])
    {
        UIAlertController * alter=[UIAlertController alertControllerWithTitle:@"提示" message:@"活跃度不足。推荐好友赢积分！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alterAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alter addAction:alterAction];
        [self presentViewController:alter animated:YES completion:nil];
    }
    else
    {
        
//        UIAlertController * alter=[UIAlertController alertControllerWithTitle:@"请输入密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction * alterAction1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            //上传数据
//            //[passfield resignFirstResponder];
//            if (pwdString.length<1) {
//                NSLog(@"%@",pwdString);
//                UIAlertController * alter1=[UIAlertController alertControllerWithTitle:@"请输入密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction * action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    
//                }];
//                [alter1 addAction:action];
//                [self presentViewController:alter1 animated:YES completion:nil];
//            }else
//            {
//            [self UpLoadRecommendData];
//            }
//        }];
//        
//        UIAlertAction * alterAction2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //[passfield resignFirstResponder];
//            WithdrawalsView.alpha=0;
//            
//        }];
//        [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//            
//            textField.placeholder=@"请输入密码";
//            textField.secureTextEntry=YES;
//            textField.borderStyle=UITextBorderStyleNone;
//            textField.delegate=self;
//            
//        }];
//        
//        [alter addAction:alterAction1];
//        [alter addAction:alterAction2];
//        [self presentViewController:alter animated:YES completion:nil];
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"请输入密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert setAlertViewStyle:UIAlertViewStyleSecureTextInput];
        UITextField *PwdField = [alert textFieldAtIndex:0];
        PwdField.placeholder = @"请输入密码";
        PwdField.secureTextEntry=YES;
        
        [alert show];
    }
    
}

/**
 *
 实现TextField协议方法
 */

#pragma mark--------UITextFieldDelegate------------
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:WithdrawalsView]) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            } completion:^(BOOL b) {
        }];
        
       }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }];
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }];
    [textField resignFirstResponder];
    return YES;

}
/***
 返回推荐奖励页面
 */
-(void)CancelWithdrawalsView:(UIButton*)button
{
    WithdrawalsView.alpha=0;
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }];
    [Withfield resignFirstResponder];
    //[passfield resignFirstResponder];
}
/***
    网络请求数据
 */
-(void)request_getWithdrawalsInfo{
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeBlack];;
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    [dict setObject:@"UserRecommend.index" forKey:@"service"];
    [dict setObject:get_sp(kSessionKey) forKey:@"sessionkey"];
    [dict setObject:get_sp(kUserID) forKey:@"user_id"];
    
    [[Mall_APIManager sharedManager]request_UserRecommend_indexWithParams:dict andBlock:^(id data,NSError* error){
        NSLog(@"%@",data);
        NSNumber* ret=[data objectForKey:@"ret"];
        if([ret isEqualToNumber:kRequestSuccess]){
            WithdrawalInfo=[[[data objectForKey:@"data"] objectForKey:@"content"] objectForKey:@"userInfo"];
            string=[[[data objectForKey:@"data"]objectForKey:@"content"]objectForKey:@"explain"];
            [self.collection reloadData];
            [self.tableView reloadData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });

        }else if([ret isEqualToNumber:kRequestUserNoLogin]){
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"亲，请重新登录哦" maskType:SVProgressHUDMaskTypeBlack];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if([ret isEqualToNumber:kRequestNotHaveData]){
            //[self.collection endRefreshing];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"对不起，加载不出数据" maskType:SVProgressHUDMaskTypeBlack];
            });
                
        }else if([ret isEqualToNumber:kRequestError]){
           
        }else if([ret isEqualToNumber:kVersionTooOld]){
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"检查更新" message:@"亲，您的应用版本过低，请下载最新版本的应用！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
/***
 上传积分，兑换红金宝
 */
-(void)UpLoadRecommendData
{
    //[SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeBlack];;
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    [dict setObject:@"UserRecommend.integralHJB" forKey:@"service"];
    [dict setObject:get_sp(kSessionKey) forKey:@"sessionkey"];
    [dict setObject:get_sp(kUserID) forKey:@"user_id"];
    [dict setObject:Withfield.text forKey:@"user_money"];
    [dict setObject:[[Mall_APIClient sharedJsonClient] md5:pwdString] forKey:@"pay_password"];
    
    [[Mall_APIManager sharedManager]request_UserRecommend_integralWithParams:dict andBlock:^(id data, NSError *error) {
        NSLog(@"%@",data);
        NSNumber* ret=[data objectForKey:@"ret"];
        if([ret isEqualToNumber:kRequestSuccess]){
            //WithdrawalInfo=[[[data objectForKey:@"data"] objectForKey:@"content"] objectForKey:@"userInfo"];
            string=[[data objectForKey:@"data"]objectForKey:@"content"];
            UIAlertController * alter=[UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * alterAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                WithdrawalsView.alpha=0;
                [self viewWillAppear:YES];
            }];
            
            [alter addAction:alterAction];
            [self presentViewController:alter animated:YES completion:nil];
            
            [self NSTimePushControl ];
           
        }else if([ret isEqualToNumber:kRequestUserNoLogin]){
            //[SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"亲，请重新登录哦" maskType:SVProgressHUDMaskTypeBlack];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if([ret isEqualToNumber:kRequestNotHaveData]){
            //[self.collection endRefreshing];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //[SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"对不起，加载不出数据" maskType:SVProgressHUDMaskTypeBlack];
            });
            
        }else if([ret isEqualToNumber:kRequestError]){
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            NSLog(@"%@",[data objectForKey:@"msg"]);
            
        }else if([ret isEqualToNumber:kVersionTooOld]){
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"检查更新" message:@"亲，您的应用版本过低，请下载最新版本的应用！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self request_getWithdrawalsInfo];
}
//时间定时器
-(void)NSTimePushControl
{
    NSTimer * timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(HandWithAlert:) userInfo:nil repeats:NO];
    [timer fire];
    
}
-(void)HandWithAlert:(NSTimer*)timer{
    
    
    
}
/***
 实现UIALertVIewDelegate代理
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField * password = [alertView textFieldAtIndex:0];
        pwdString=password.text;
        NSLog(@"Pwd===============================================================%@",pwdString);
    }
    if (buttonIndex==0) {
        WithdrawalsView.alpha=0;
    }
    else{
        if (pwdString.length<1) {
            NSLog(@"%@",pwdString);
            UIAlertController * alter1=[UIAlertController alertControllerWithTitle:@"请输入密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            }];
            [alter1 addAction:action];
            [self presentViewController:alter1 animated:YES completion:nil];
        }else
        {
            NSLog(@"%@",pwdString);
            [self UpLoadRecommendData];
        }

    
    }
}
@end

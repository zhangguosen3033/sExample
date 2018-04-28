//
//  GSRunningMaLight.m
//  mall3658
//
//  Created by fjs  on 2018/4/28.
//  Copyright © 2018年 yangsu. All rights reserved.
//

#import "GSRunningMaLight.h"

@implementation GSRunningMaLight

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [Toolkit getColor:@"f6ecbd"];
        [self addSubview:self.trumpet];
        //        [self addSubview:self.lightView];
        [self makeAutoLayerOuter];
    }
    return self;
}
#pragma mark=========初始化方法==========
- (UIImageView *)trumpet{
    if (_trumpet == nil) {
        _trumpet = [[UIImageView alloc]init];
        [_trumpet setImage:[UIImage imageNamed:@"小喇叭@2x"]];
    }
    return _trumpet;
}

#pragma mark=======makeAutoLayerOuter============
-(void)makeAutoLayerOuter
{
    [self.trumpet makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(17*ratio_width);
        make.width.height.equalTo(17*ratio_width);
        
    }];
    
    
}

-(void)setMessage:(NSString *)str
{
    _lightView=[[SXMarquee alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 32) speed:3 Msg:str bgColor:[Toolkit getColor:@"f6ecbd"] txtColor:[Toolkit getColor:@"ff5600"]];
    
    [self addSubview:self.lightView];
    [_lightView start];
    [_lightView changeTapMarqueeAction:^{
        UIAlertController* alertC = [UIAlertController alertControllerWithTitle:@"预警信息" message:[NSString stringWithFormat:@"当前预警信息提示：%@\n如有问题请及时核查",str] preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
    }];
    [self.lightView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.trumpet.mas_right).offset(10*ratio_width);
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(0);
        make.height.equalTo(@(32));
    }];
}
-(void)closeRunLight
{
    [_lightView stop];
    [_lightView removeFromSuperview];
}

@end

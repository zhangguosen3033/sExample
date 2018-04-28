//
//  GSRunningMaLight.h
//  mall3658
//
//  Created by fjs  on 2018/4/28.
//  Copyright © 2018年 yangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXMarquee.h"

@interface GSRunningMaLight : UIView

@property (nonatomic,strong)UIImageView *trumpet;//小喇叭
@property (nonatomic,strong)SXMarquee *lightView;//跑马灯labelview

-(void)setMessage:(NSString *)str;
-(void)closeRunLight;
@end

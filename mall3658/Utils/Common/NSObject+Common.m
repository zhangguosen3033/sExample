//
//  NSObject+Common.m
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/8.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "NSObject+Common.h"
#import "NetworkResponseUtility.h"

@implementation NSObject (Common)

#pragma mark Tip M
- (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if ([error.userInfo objectForKey:@"msg"]) {
            NSArray *msgArray = [[error.userInfo objectForKey:@"msg"] allValues];
            NSUInteger num = [msgArray count];
            for (int i = 0; i < num; i++) {
                NSString *msgStr = [msgArray objectAtIndex:i];
                if (i+1 < num) {
                    [tipStr appendString:[NSString stringWithFormat:@"%@\n", msgStr]];
                }else{
                    [tipStr appendString:msgStr];
                }
            }
        }else{
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else{
                [tipStr appendFormat:@"ErrorCode%ld", (long)error.code];
            }
        }
        return tipStr;
    }
    return nil;
}
- (BOOL)showError:(NSError *)error{
    //    if ([JDStatusBarNotification isVisible]) {//如果statusBar上面正在显示信息，则不再用hud显示error
    //        NSLog(@"如果statusBar上面正在显示信息，则不再用hud显示error");
    //        return NO;
    //    }
    NSString *tipStr = [self tipFromError:error];
    [self showHudTipStr:tipStr];
    return YES;
}
- (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0];
    }
}
#pragma mark NetError
-(id)handleResponse:(id)responseJSON{
    return [self handleResponse:responseJSON autoShowError:YES];
}

-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    NSDictionary *dict;
    
    if ([responseJSON isKindOfClass:[NSDictionary class]]) {
        
        dict = responseJSON;
        
        if ([dict[@"ret"] isEqualToNumber:kRequestUserNoLogin]) {
            
            dict = nil;
            
            UITabBarController *tabBarController = (UITabBarController *)_app_.window.rootViewController;
            
            if ([tabBarController isKindOfClass:[UITabBarController class]]) {
                UINavigationController *navigationController = tabBarController.selectedViewController;
                
//                if (![[navigationController.viewControllers lastObject] isKindOfClass:[LogInViewController class]] && ![[[NSUserDefaults standardUserDefaults] objectForKey:kLoginCreatIndicator] boolValue]) {
//
//                    [[UserState sharedManager] logout];
//                    [self showHudTipStr:[responseJSON objectForKey:@"msg"]];
//                    LogInViewController *viewController = [[LogInViewController alloc] init];
//                    viewController.comeformType = Comeform_LogOut_401;
//                    [navigationController pushViewController:viewController animated:YES];
//
//                    if ([SVProgressHUD isVisible]) {
//                        [SVProgressHUD dismiss];
//                    }
//                }
            }
            
        } else if ([dict[@"ret"] isEqualToNumber:kVersionTooOld]) {
            dict = nil;
            
            if ([SVProgressHUD isVisible]) {
                [SVProgressHUD dismiss];
            }
            
            if ([Toolkit topViewController].navigationController) {
                [self checkAppUpdate];
            }
        }
        
    } else if ([responseJSON isKindOfClass:[NSError class]]) {
        
    }
    
    return dict;
}

- (void)checkAppUpdate {
    
    if (_app_.isCheckingUpdate || _app_.isShownUpdatePromptView) {
        return;
    }
    
    _app_.isCheckingUpdate = YES;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"Version.IsNew" forKey:@"service"];
    [dict setObject:@"ios-1.2" forKey:@"cur_version"];
    
    WS(ws);
    [[Mall_APIManager sharedManager] request_Check_Version_Update:dict andBlock:^(id data, NSError *error) {
        
        if ([SVProgressHUD isVisible]) {
            [SVProgressHUD dismiss];
        }
        
        NSNumber* ret=[data objectForKey:@"ret"];
        if ([ret isEqualToNumber:kRequestSuccess]){
            
            NSDictionary *content = data[@"data"][@"content"];
            
            if ([content[@"is_have_new"] intValue] == 1) {
                [ws alertUpdateVersionInfo:content[@"new_desc"] isFroce:([content[@"is_force_update"] intValue] == 1) url:content[@"new_url"]];
            };
        }
        
        _app_.isCheckingUpdate = NO;
        
    }];
}

- (void)alertUpdateVersionInfo:(NSString *)versionInfo isFroce:(BOOL)isFroce url:(NSString *)url {
    if (versionInfo == nil || [versionInfo isKindOfClass:[NSNull class]])
    {
        return;
    }
    
    _app_.isShownUpdatePromptView = YES;
    
    _app_.isUpdatePromptVisible = YES;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本" message:versionInfo preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (IsEnterprise == 1) {
            
//            UpdateWebViewController *vc = [[UpdateWebViewController alloc] initWithURL:url title:@"版本更新"];
//            vc.disableSlideBack = isFroce;
//            vc.showLeftNaviButton = !isFroce;
//            [[Toolkit topViewController].navigationController pushViewController:vc animated:YES];
            
        } else {
            
            //拼凑跳转链接，跳转App Store打开APP
            NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",kAppId];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
        
        _app_.isUpdatePromptVisible = NO;
        
        if (!isFroce) {
            _app_.isShownUpdatePromptView = NO;
        }
        
    }];
    [alertController addAction:okAction];
    
    if (!isFroce) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            _app_.isUpdatePromptVisible = NO;
            
            _app_.isShownUpdatePromptView = NO;
            
        }];
        [alertController addAction:cancleAction];
    }
    
    [[Toolkit topViewController] presentViewController:alertController animated:YES completion:nil];
}


@end

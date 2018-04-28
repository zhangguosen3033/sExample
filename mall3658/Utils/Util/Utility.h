//
//  Utility.h
//  mall3658
//
//  Created by 于兆海 on 2017/9/11.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text delegate:(id<UITextFieldDelegate>)delegate;

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor titleFont:(UIFont *)titleFont cornerRadius:(float)cornerRadius Target:(id)target action:(SEL)action;

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;

+ (UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius image:(UIImage *)image contentMode:(NSNumber *)contentMode;

+ (UIView *)viewWithBackgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius;

+ (UITableView *)tableViewStyle:(UITableViewStyle)style backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle dataSource:(id <UITableViewDataSource>)dataSource delegate:(id <UITableViewDelegate>)delegate;

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end


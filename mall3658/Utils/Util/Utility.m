//
//  Utility.m
//  mall3658
//
//  Created by 于兆海 on 2017/9/11.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text delegate:(id<UITextFieldDelegate>)delegate{
    UITextField *view = [[UITextField alloc] init];
    
    if (placeholder) {
        view.placeholder = placeholder;
    }
    
    if (backgroundColor) {
        view.backgroundColor = backgroundColor;
    }
    
    if (borderColor) {
        view.layer.borderColor = borderColor.CGColor;
        view.layer.borderWidth = 0.5;
    }
    
    if (cornerRadius > 0) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = YES;
    }
    
    if (font) {
        view.font = font;
    }
    
    if (textColor) {
        view.textColor = textColor;
    }
    
    if (text) {
        view.text = text;
    }
    
    if (delegate) {
        view.delegate = delegate;
    }
    
    view.textAlignment = textAlignment;
    
    return view;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor titleFont:(UIFont *)titleFont cornerRadius:(float)cornerRadius Target:(id)target action:(SEL)action{
    UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (title) {
        [view setTitle:title forState:UIControlStateNormal];
    }
    
    if (titleColor) {
        [view setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    if (borderColor) {
        view.layer.borderColor = borderColor.CGColor;
        view.layer.borderWidth = 0.5;
    }
    
    if (backgroundColor) {
        view.backgroundColor = backgroundColor;
    }
    
    if (titleFont) {
        view.titleLabel.font = titleFont;
    }
    
    if (cornerRadius > 0) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = YES;
    }
    
    if (target && action) {
        [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return view;
}

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text{
    UILabel *view = [[UILabel alloc] init];
    
    if (backgroundColor) {
        view.backgroundColor = backgroundColor;
    }
    
    if (borderColor) {
        view.layer.borderColor = borderColor.CGColor;
        view.layer.borderWidth = 0.5;
    }
    
    if (cornerRadius > 0) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = YES;
    }
    
    if (font) {
        view.font = font;
    }
    
    if (textColor) {
        view.textColor = textColor;
    }
    
    view.textAlignment = textAlignment;
    
    if (text) {
        view.text = text;
    }
    
    return view;
}

+ (UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius image:(UIImage *)image contentMode:(NSNumber *)contentMode{
    UIImageView *view = [[UIImageView alloc] init];
    
    if (backgroundColor) {
        view.backgroundColor = backgroundColor;
    }
    
    if (borderColor) {
        view.layer.borderColor = borderColor.CGColor;
        view.layer.borderWidth = 0.5;
    }
    
    if (cornerRadius > 0) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = YES;
    }
    
    if (image) {
        [view setImage:image];
    }
    
    if (contentMode) {
        view.contentMode = [contentMode integerValue];
    }
    
    return view;
}

+ (UIView *)viewWithBackgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius{
    UIView *view = [[UIView alloc] init];
    
    if (backgroundColor) {
        view.backgroundColor = backgroundColor;
    }
    
    if (borderColor) {
        view.layer.borderColor = borderColor.CGColor;
        view.layer.borderWidth = 0.5;
    }
    
    if (cornerRadius > 0) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = YES;
    }
    
    return view;
}

+ (UITableView *)tableViewStyle:(UITableViewStyle)style backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate{
    
    UITableView *view = [[TableView alloc] initWithFrame:CGRectZero style:style];
    
    if (backgroundColor) {
        view.backgroundColor = backgroundColor;
    }
    
    view.separatorStyle = separatorStyle;
    
    if (dataSource) {
        view.dataSource = dataSource;
    }
    
    if (delegate) {
        view.delegate = delegate;
    }
    
    if (borderColor) {
        view.layer.borderColor = borderColor.CGColor;
        view.layer.borderWidth = 0.5;
    }
    
    [Toolkit setContentInsetAdjustmentBehaviorNever4ScrollView:view];
    
    return view;
}

//压缩图片
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end


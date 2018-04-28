//
//  ZHViewTools.h
//  ZHTools
//
//  Created by 于兆海 (QQ:695885883) on 2016/9/26.
//  Copyright © 2016年 于兆海. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *ZHViewPropertyName;

extern ZHViewPropertyName ZHView_Tag;/**< 传值示例：@5201314 */
extern ZHViewPropertyName ZHView_Frame;/**< 传值示例：[NSValue valueWithCGRect:rect] */
extern ZHViewPropertyName ZHView_Hidden;/**< 传值示例：@(YES) */
extern ZHViewPropertyName ZHView_BorderColor;
extern ZHViewPropertyName ZHView_BorderWidth;/**< 传值示例：@52.1 */
extern ZHViewPropertyName ZHView_CornerRadius;/**< 传值示例：@5.21 */
extern ZHViewPropertyName ZHView_ClipsToBounds;/**< 传值示例：@(NO) */
extern ZHViewPropertyName ZHView_BackgroundColor;
extern ZHViewPropertyName ZHView_UserInteractionEnabled;/**< 传值示例：@(NO) */
extern ZHViewPropertyName ZHView_ContentMode;/**< 传值示例：@(UIViewContentModeCenter) */

extern ZHViewPropertyName ZHTableView_Delegate;
extern ZHViewPropertyName ZHTableView_DataSource;
extern ZHViewPropertyName ZHTableView_SeparatorStyle;/**< 传值示例：@(UITableViewCellSeparatorStyle) */
extern ZHViewPropertyName ZHTableView_SeparatorColor;

extern ZHViewPropertyName ZHTextField_Text;
extern ZHViewPropertyName ZHTextField_Font;
extern ZHViewPropertyName ZHTextField_Delegate;
extern ZHViewPropertyName ZHTextField_TextColor;
extern ZHViewPropertyName ZHTextField_Placeholder;
extern ZHViewPropertyName ZHTextField_KeyboardType;/**< 传值示例：@(UIKeyboardTypeNamePhonePad) */
extern ZHViewPropertyName ZHTextField_TextAligment;/**< 传值示例：@(NSTextAlignmentCenter) */

extern ZHViewPropertyName ZHLabel_Text;
extern ZHViewPropertyName ZHLabel_Font;
extern ZHViewPropertyName ZHLabel_TextColor;
extern ZHViewPropertyName ZHLabel_TextAlignment;/**< 传值示例：@(NSTextAlignmentCenter) */
extern ZHViewPropertyName ZHLabel_NumberOfLines;/**< 传值示例：@(0) */

extern ZHViewPropertyName ZHImageView_Image;
extern ZHViewPropertyName ZHImageView_Hilighted;/**< 传值示例：@(YES) */
extern ZHViewPropertyName ZHImageView_HilightedImage;

extern ZHViewPropertyName ZHButton_Font;
extern ZHViewPropertyName ZHButton_Selected;/**< 传值示例：@(YES) */
extern ZHViewPropertyName ZHButton_NormalImage;
extern ZHViewPropertyName ZHButton_SelectedImage;
extern ZHViewPropertyName ZHButton_NormalTitle;
extern ZHViewPropertyName ZHButton_SelectedTitle;
extern ZHViewPropertyName ZHButton_NormalTitleColor;
extern ZHViewPropertyName ZHButton_SelectedTitleColor;


/*!
 *  @Author ZH
 *
 *  @brief  根据键值对创建view->[ZHViewTools viewWithKeyValues:@{ZHView_Tag: @5201314)]}]
 */
@interface ZHViewTools : NSObject

+ (UIView *)viewWithKeyValues:(NSDictionary *)keyValues;

+ (UILabel *)labelWithKeyValues:(NSDictionary *)keyValues;

+ (UIButton *)buttonWithKeyValues:(NSDictionary *)keyValues;

+ (UITableView *)tableViewWithKeyValues:(NSDictionary *)keyValues;

+ (UITextField *)textFieldWithKeyValues:(NSDictionary *)keyValues;

+ (UIImageView *)imageViewWithKeyValues:(NSDictionary *)keyValues;

+ (id)viewWithClass:(Class)vClass keyValues:(NSDictionary *)keyValues;

@end

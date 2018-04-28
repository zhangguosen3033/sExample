//
//  NearByDetailTableViewCell.h
//  mall3658
//
//  Created by ygkj on 2017/9/5.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol nearStorePhoneTableViewCellDelegate <NSObject>

-(void)clickPhone:(NSIndexPath *)index;

@end
@interface NearByDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * titleLb;
@property(nonatomic,strong)UIImageView * starImage;
@property(nonatomic,strong)UIImageView * mapImage; //小地图坐标的logo
@property(nonatomic,strong)NSIndexPath * index;

@property(nonatomic,assign)id<nearStorePhoneTableViewCellDelegate>delegate;

@end

//
//  NearbymerchantsTableViewCell.h
//  mall3658
//
//  Created by ygkj on 2017/9/5.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol nearStoreStarTableViewCellDelegate <NSObject>

-(void)starNearStore:(NSIndexPath *)index;
-(void)distanceMaptapAction:(NSIndexPath *)index;
@end

@interface NearbymerchantsTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * storeImage;
@property(nonatomic,strong)UILabel * titleLb;
@property(nonatomic,strong)UILabel * smallTitleLb;

@property(nonatomic,strong)UIView * lineView;


@end

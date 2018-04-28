//
//  NearbymerchantsTableViewCell.m
//  mall3658
//
//  Created by ygkj on 2017/9/5.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "NearbymerchantsTableViewCell.h"

@implementation NearbymerchantsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.smallTitleLb];
        [self.contentView addSubview:self.lineView];

        [self.contentView addSubview:self.storeImage];

         [self MakeAutoLayerOuter];
    }
    return self;
}

#pragma mark========Setter/Getter方法===========
-(UILabel*)titleLb
{
    if (!_titleLb) {
        _titleLb=[UILabel new];
        _titleLb.textColor=[Toolkit getColor:@"282828"];
        _titleLb.font=[UIFont systemFontOfSize:16];
        _titleLb.textAlignment=NSTextAlignmentLeft;
        _titleLb.adjustsFontSizeToFitWidth =YES;
        _titleLb.text =@"温度";
        //        _titleLb.backgroundColor =[UIColor redColor];
    }
    return _titleLb;
}
-(UILabel*)smallTitleLb
{
    if (!_smallTitleLb) {
        _smallTitleLb=[UILabel new];
        _smallTitleLb.textColor=[Toolkit getColor:hex_1D85FF];
        _smallTitleLb.font=[UIFont systemFontOfSize:16];
        _smallTitleLb.textAlignment=NSTextAlignmentLeft;
        _smallTitleLb.adjustsFontSizeToFitWidth =YES;
        _smallTitleLb.text =@"24.22";

    }
    return _smallTitleLb;
}

-(UIImageView*)storeImage
{
    if (!_storeImage) {
        _storeImage=[UIImageView new];
        _storeImage.image =[UIImage imageNamed:@"附近商家收藏-普通@2x"];
    }
    return _storeImage;
}
-(UIView*)lineView
{
    if (!_lineView) {
        _lineView=[UIView new];
        _lineView.backgroundColor =[Toolkit getColor:hex_aaaaaa];
    }
    return _lineView;
}



-(void)MakeAutoLayerOuter{
    
    [self.storeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15*ratio_width);
        make.width.height.equalTo(@(130/2.0*ratio_width));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.storeImage.mas_right).offset(15*ratio_width);
        make.top.equalTo(self.contentView).offset(25*ratio_width);
        make.width.equalTo(@(400/2.0*ratio_width));
        make.height.equalTo(@(32/2.0*ratio_width));
    }];
    [self.smallTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.storeImage.mas_right).offset(15*ratio_width);
        make.top.equalTo(self.titleLb.mas_bottom).offset(40/2.0*ratio_width);
        make.width.equalTo(@(400/2.0*ratio_width));
        make.height.equalTo(@(28/2.0*ratio_width));
    }];
 
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15*ratio_width);
        make.left.equalTo(self.contentView).offset(15*ratio_width);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(0.5);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

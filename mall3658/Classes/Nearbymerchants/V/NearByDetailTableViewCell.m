//
//  NearByDetailTableViewCell.m
//  mall3658
//
//  Created by ygkj on 2017/9/5.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "NearByDetailTableViewCell.h"

@implementation NearByDetailTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.starImage];
        [self.contentView addSubview:self.mapImage];

        [self MakeAutoLayerOuter];
    }
    return self;
}
-(void)starClick{
    if (_delegate) {
        [self.delegate clickPhone:self.index];
    }
}

#pragma mark========Setter/Getter方法===========
-(UILabel*)titleLb
{
    if (!_titleLb) {
        _titleLb=[UILabel new];
        _titleLb.textColor=[Toolkit getColor:@"606060"];
        _titleLb.font=[UIFont systemFontOfSize:12];
        _titleLb.textAlignment=NSTextAlignmentLeft;
        _titleLb.numberOfLines = 0;
        //        _titleLb.backgroundColor =[UIColor redColor];
        _titleLb.text =@"";
//        _titleLb.adjustsFontSizeToFitWidth =YES;
    }
    return _titleLb;
}
-(UIImageView*)starImage
{
    if (!_starImage) {
        _starImage=[UIImageView new];
        _starImage.image =[UIImage imageNamed:@"商家详情电话@2x"];
        _starImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(starClick)];
        [_starImage addGestureRecognizer:tap];
        _starImage.hidden = YES;
    }
    return _starImage;
}
-(UIImageView*)mapImage
{
    if (!_mapImage) {
        _mapImage=[UIImageView new];
        _mapImage.image =[UIImage imageNamed:@"商家详情地图@2x"];
        _mapImage.hidden = YES;
    }
    return _mapImage;
}

-(void)MakeAutoLayerOuter{
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15*ratio_width);
        make.top.equalTo(self.contentView).offset(13*ratio_width);
        make.right.equalTo(self.contentView).offset(-15*ratio_width);
        make.bottom.equalTo(self.contentView).offset(-10*ratio_width);
    }];
    [self.mapImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(13*ratio_width);
        make.left.equalTo(self.contentView).offset(11*ratio_width);
        make.height.equalTo(@(21*ratio_width));
        make.width.equalTo(@(21*ratio_width));
    }];
    [self.starImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(13*ratio_width);
        make.right.equalTo(self.contentView).offset(-25/2.0*ratio_width);
        make.height.equalTo(@(22*ratio_width));
        make.width.equalTo(@(22*ratio_width));
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

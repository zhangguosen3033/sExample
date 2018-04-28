//
//  FreeShareSettlementTableViewCell.m
//  mall3658
//
//  Created by ygkj on 2017/11/8.
//  Copyright © 2017年 yangsu. All rights reserved.
//

#import "FreeShareSettlementTableViewCell.h"

@implementation FreeShareSettlementTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.descLb];
        [self.contentView addSubview:self.timeLb];
        [self.contentView addSubview:self.lineView];

        [self MakeAutoLayerOuter];
    }
    return self;
}

#pragma mark========Setter/Getter方法===========
-(UILabel*)titleLb
{
    if (!_titleLb) {
        _titleLb=[UILabel new];
        _titleLb.textColor=[Toolkit getColor:@"606060"];
        _titleLb.font=[UIFont systemFontOfSize:20];
        _titleLb.textAlignment=NSTextAlignmentLeft;
        _titleLb.numberOfLines = 0;
        _titleLb.text =@"🐷厂01";
    }
    return _titleLb;
}
-(UILabel*)descLb
{
    if (!_descLb) {
        _descLb=[UILabel new];
        _descLb.textColor=[Toolkit getColor:hex_aaaaaa];
        _descLb.font=[UIFont systemFontOfSize:13];
        _descLb.textAlignment=NSTextAlignmentLeft;
        _descLb.numberOfLines = 0;
        _descLb.text =@"加了一把猪饲料";
    }
    return _descLb;
}
-(UILabel*)timeLb
{
    if (!_timeLb) {
        _timeLb=[UILabel new];
        _timeLb.textColor=[Toolkit getColor:hex_aaaaaa];
        _timeLb.font=[UIFont systemFontOfSize:13];
        _timeLb.textAlignment=NSTextAlignmentLeft;
        _timeLb.numberOfLines = 0;
        _timeLb.text =@"2018/4/25 15:26:20";
    }
    return _timeLb;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView=[UIView new];
        _lineView.backgroundColor =[Toolkit getColor:hex_e5e5e5];
    }
    return _lineView;
}


-(void)MakeAutoLayerOuter{
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView).offset(15);
        make.height.equalTo(@14);
    }];
    [self.descLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.titleLb.mas_bottom).offset(5);
        make.height.equalTo(@50);
    }];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLb);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.equalTo(@(18*ratio_width));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@(0.6));
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

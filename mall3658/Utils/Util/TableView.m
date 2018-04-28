//
//  TableView.m
//  mall3658
//
//  Created by hello on 2017/10/13.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "TableView.h"

@implementation TableView

- (instancetype)init {
    if (self = [super init]) {
        [Toolkit setContentInsetAdjustmentBehaviorNever4ScrollView:self];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [Toolkit setContentInsetAdjustmentBehaviorNever4ScrollView:self];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [Toolkit setContentInsetAdjustmentBehaviorNever4ScrollView:self];
    }
    return self;
}

@end


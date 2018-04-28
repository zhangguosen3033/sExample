//
//  CollectionView.m
//  mall3658
//
//  Created by hello on 2017/10/13.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView

- (instancetype)init {
    if (self = [super init]) {
        [Toolkit setContentInsetAdjustmentBehaviorNever4ScrollView:self];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [Toolkit setContentInsetAdjustmentBehaviorNever4ScrollView:self];
    }
    return self;
}

@end

//
//  GSscrolLabel.h
//  mall3658
//
//  Created by ygkj on 17/2/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    ATAnimationTypeFadeInOut = 1,
    ATAnimationTypeSlideLeftInLeftOut = 2,
    ATAnimationTypeSlideRightInRightOut = 3,
    ATAnimationTypeSlideTopInTopOut = 4,
    ATAnimationTypeSlideBottomtInBottomOut = 5,
    ATAnimationTypeSlideLeftInRightOut = 6,
    ATAnimationTypeSlideRightInLeftOut = 7,
    ATAnimationTypeSlideBottomInTopOut = 8,
    ATAnimationTypeSlideTopInBottomOut = 9
};
typedef NSUInteger ATAnimationType;

@interface GSscrolLabel : UILabel
/**
 `wordList` is the list of words that has to be shuffled.
 */
@property(nonatomic, retain) NSArray *wordList;

/**
 `duration` duration of the animation.
 */
@property(nonatomic, assign) double duration;

/**
 `ATAnimationType` for animation of the text.
 */
@property(nonatomic, assign) ATAnimationType animationType;

@property(nonatomic,strong) NSNumber * index  ;


///---------------------------
/// @name Animating function for the label's extension.
///---------------------------

/**
 *  Animate the words from the list
 *
 *  @param words list of words.
 *  @param time  total duration of the animation between each switch.
 */
- (void)animateWithWords:(NSArray *)words forDuration:(double)time;

/**
 *  Animation with the type of animation type.
 *
 *  @param words     list of words.
 *  @param time      total duration of the animation between each switch.
 *  @param animation type of animation
 */
- (void)animateWithWords:(NSArray *)words forDuration:(double)time withAnimation:(ATAnimationType)animation isNSAttributedString:(BOOL)isNSAttributedString;


@end

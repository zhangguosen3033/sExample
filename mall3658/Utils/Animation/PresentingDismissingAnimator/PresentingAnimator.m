//
//  PopAnimator.m
//  Popping
//
//  Created by André Schneider on 14.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "PresentingAnimator.h"
#import <POP/POP.h>

@interface PresentingAnimator ()

@property(nonatomic, assign) NSInteger viewHeight;

@end

@implementation PresentingAnimator

- (id) initWithHeight:(NSInteger) aHeight
{
    self = [super init];
    if (self) {
        self.viewHeight = aHeight;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;

    UIView *dimmingView = [[UIView alloc] initWithFrame:fromView.bounds];
    dimmingView.backgroundColor = [UIColor darkGrayColor];

    dimmingView.layer.opacity = 0.0;
    
    NSInteger toViewHeight = self.viewHeight < 100 ? 500 : self.viewHeight;
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.frame = CGRectMake(0,
                              0,
                              SCREEN_WIDTH,
                              toViewHeight);
    //!!!: 去掉中心center这句话时会出现短暂白影
    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);

    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:toView];

    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.fromValue=@(SCREEN_HEIGHT*3);
    positionAnimation.toValue = @(SCREEN_HEIGHT-toViewHeight/2);
    positionAnimation.springBounciness = 10;
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 20;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];

    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.5);

    [toView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    POPBasicAnimation* scaleAnimationFromView=[POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimationFromView.toValue=[NSValue valueWithCGPoint:CGPointMake(.8, .8)];
    
    [fromView.layer pop_addAnimation:scaleAnimationFromView forKey:@"scaleAnimationFromView"];
    
}

@end

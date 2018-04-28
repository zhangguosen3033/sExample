//
//  ScalePresentingAnimator.m
//  mall3658
//
//  Created by yanglicheng-Leo on 15/7/23.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "ScalePresentingAnimator.h"

@implementation ScalePresentingAnimator


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;
    
    
    
//    NSInteger toViewHeight=500;
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.frame = CGRectMake(0,
                              0,
                              SCREEN_WIDTH,
                              SCREEN_HEIGHT);
    //!!!: 去掉中心center这句话时会出现短暂白影
    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
    UIView *dimmingView = [[UIView alloc] initWithFrame:toView.bounds];
    dimmingView.backgroundColor = [UIColor darkGrayColor];
    
    dimmingView.layer.opacity = 0.0;
    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:toView];
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.fromValue=@(SCREEN_HEIGHT*3);
    positionAnimation.toValue = @(SCREEN_HEIGHT/2);
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

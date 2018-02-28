//
//  Animator.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/26/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "Animator.h"

@implementation Animator

+ (void)animateBounce:(UIView *)view {
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAutoreverse animations:^{
        view.transform = CGAffineTransformMakeScale(1.5,1.5);
    } completion:^(BOOL finished) {
        view.transform = CGAffineTransformMakeScale(1,1);
    }];
}

+ (void)animateBounceIn:(UIView *)view {
    [UIView animateWithDuration:0.2f animations:^{
        view.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    }];
}

+ (void)animateBounceOut:(UIView *)view {
    [UIView animateWithDuration:0.2f animations:^{
        view.transform = CGAffineTransformIdentity;
    }];
}

@end

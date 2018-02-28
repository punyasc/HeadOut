//
//  Animator.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/26/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Animator : NSObject

+ (void)animateBounce:(UIView *)view;

+ (void)animateBounceIn:(UIView *)view;

+ (void)animateBounceOut:(UIView *)view;

@end

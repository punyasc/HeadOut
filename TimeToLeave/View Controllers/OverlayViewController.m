//
//  OverlayViewController.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/21/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "OverlayViewController.h"

@interface OverlayViewController ()

@end

@implementation OverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideShade:) name:@"HideShade" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showShade:) name:@"ShowShade" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideActivityModal:) name:@"HideActivityModal" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showActivityModal:) name:@"ShowActivityModal" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)hideShade:(NSNotification *)notification {
    NSLog(@"hide shade");
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.shadeView setAlpha:0.0];
    } completion:nil];
}

- (void)showShade:(NSNotification *)notification {
    NSLog(@"show shade");
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.shadeView setAlpha:0.5];
    } completion:nil];
}

- (void)hideActivityModal:(NSNotification *)notification {
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.activityModal setAlpha:0.0];
    } completion:nil];
}

- (void)showActivityModal:(NSNotification *)notification {
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.activityModal setAlpha:0.5];
    } completion:nil];
}

@end

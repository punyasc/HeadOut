//
//  AppConstants.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/16/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "AppConstants.h"

@implementation AppConstants

int kDriveMode = 0;
int kBikeMode = 1;
int kWalkMode = 2;

int kAppleMode = 0;
int kGoogleMode = 1;
int kWazeMode = 2;


+ (UIColor *)defaultIconColor {
    return [UIColor colorWithRed:0.17 green:0.59 blue:0.96 alpha:1.0];
}

+ (UIColor *)selectedIconColor {
    return [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
}

@end

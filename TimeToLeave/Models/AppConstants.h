//
//  AppConstants.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/16/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppConstants : NSObject

extern int kDriveMode;
extern int kBikeMode;
extern int kWalkMode;

extern int kAppleMode;
extern int kGoogleMode;
extern int kWazeMode;

+ (UIColor *)defaultIconColor;

+ (UIColor *)selectedIconColor;

@end

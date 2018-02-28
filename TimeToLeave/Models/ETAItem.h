//
//  ETAItem.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/15/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ETAItem : NSObject

@property NSString *destination;
@property MKPlacemark *placemark;
@property UIImage *icon;
@property NSString *details;

- (id)initWithDestination:(NSString *)destination atPlacemark:(MKPlacemark *)placemark withIcon:(UIImage *)image;

@end

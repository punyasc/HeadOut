//
//  LocationMapViewController.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/17/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationSearchTableViewController.h"

@interface LocationMapViewController : UIViewController<LocationSearchDelegate, UISearchBarDelegate>

@property (nonatomic, assign) id<LocationSearchDelegate> delegate;

- (IBAction)cancelTapped:(UIBarButtonItem *)sender;

- (IBAction)currentLocationTapped:(UIButton *)sender;


@end

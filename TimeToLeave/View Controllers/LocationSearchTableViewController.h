//
//  LocationSearchTableViewController.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/17/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "PlacesManager.h"

@protocol LocationSearchDelegate <NSObject>

- (void)locationSelected:(MKPlacemark *)placemark;

@end

@interface LocationSearchTableViewController : UITableViewController<UISearchResultsUpdating>

@property (nonatomic, assign) id<LocationSearchDelegate> delegate;

- (void)searchWithQuery:(NSString *)searchBarText;

@end

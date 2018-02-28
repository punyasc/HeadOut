//
//  HomeTableViewController.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/15/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "ETACell.h"
#import "PlacesManager.h"
#import "BVReorderTableView.h"

@interface HomeTableViewController : UITableViewController<CLLocationManagerDelegate, ReorderTableViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)modeChanged:(UISegmentedControl *)sender;

@end

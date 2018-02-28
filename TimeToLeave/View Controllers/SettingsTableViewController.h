//
//  SettingsTableViewController.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/22/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

@interface SettingsTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *timeSegmentedControl;

- (IBAction)mapModeChanged:(UISegmentedControl *)sender;

- (IBAction)timeModeChanged:(UISegmentedControl *)sender;

- (IBAction)dismissTapped:(UIBarButtonItem *)sender;


@end

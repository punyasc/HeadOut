//
//  AddPlaceTableViewController.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/16/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "LocationSearchTableViewController.h"
#import "LocationMapViewController.h"
#import "ETAItem.h"
#import "Animator.h"


@interface AddPlaceTableViewController : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *selectedIcon;
@property (strong, nonatomic) IBOutlet ModernView *addButtonView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *iconButtons;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationSubLabel;
@property (strong, nonatomic) IBOutlet UITextField *placeNameField;

- (IBAction)iconTapped:(UIButton *)sender;

- (IBAction)addDownTapped:(UIButton *)sender;

- (IBAction)addTapped:(UIButton *)sender;

- (IBAction)addExit:(UIButton *)sender;

- (IBAction)unwindToModal:(UIStoryboardSegue *)segue;




@end

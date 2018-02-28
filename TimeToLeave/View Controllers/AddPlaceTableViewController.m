//
//  AddPlaceTableViewController.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/16/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "AddPlaceTableViewController.h"

@interface AddPlaceTableViewController ()

@property PlacesManager *places;
@property NSString *headerTitle;

@end

@implementation AddPlaceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerTitle = @"";
    self.places = [PlacesManager sharedManager];
    [self.placeNameField setDelegate:self];
    [self.locationSubLabel setAlpha:0.3];
    [self.tableView setDelaysContentTouches:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.places.selectedNewPlacemark) {
        MKPlacemark *placemark = self.places.selectedNewPlacemark;
        [self.locationSubLabel setAlpha:1.0];
        [self.locationSubLabel setText:[PlacesManager parseAddressFromPlacemark:placemark]];
    } else {
        NSLog(@"no placemark");
        PlacesManager *places = [PlacesManager sharedManager];
        [places setSelectedNewPlacemark:nil];
        [self.locationSubLabel setText:@"None chosen"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)unwindToModal:(UIStoryboardSegue *)segue {
    
}

- (IBAction)addTapped:(UIButton *)sender {
    NSLog(@"UP");
    [Animator animateBounceOut:self.addButtonView];
    if (self.placeNameField.text.length < 1 ||
        !self.selectedIcon.image ||
        !self.places.selectedNewPlacemark) {
        self.headerTitle = @"Make sure to set a name, location, and icon";
        [self.tableView reloadData];
        return;
    }
    ETAItem *newItem = [[ETAItem alloc]
                        initWithDestination:self.placeNameField.text
                        atPlacemark:self.places.selectedNewPlacemark
                        withIcon:self.selectedIcon.image];
    [PlacesManager addToFavorites:newItem];
    [self.places setSelectedNewPlacemark:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addExit:(UIButton *)sender {
    [Animator animateBounceOut:self.addButtonView];
}

- (IBAction)iconTapped:(UIButton *)sender {
    for (UIButton *button in self.iconButtons) {
        [button setTintColor:[AppConstants defaultIconColor]];
    }
    
    [self.selectedIcon setImage:sender.imageView.image];
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
         [sender setTintColor:[UIColor blackColor]];
    } completion:nil];
    
}

- (IBAction)addDownTapped:(UIButton *)sender {
    NSLog(@"DOWN");
    [Animator animateBounceIn:self.addButtonView];
}

#pragma mark - Text Field delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.headerTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        UINavigationController *searchNavVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"LocationSearchNavigationController"];
        [self presentViewController:searchNavVC animated:YES completion:nil];
    }
}

@end

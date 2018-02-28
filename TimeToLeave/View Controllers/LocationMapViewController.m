//
//  LocationMapViewController.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/17/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "LocationMapViewController.h"

@interface LocationMapViewController ()

@property CLLocationManager *locationManager;
@property UISearchController *searchController;
@property LocationSearchTableViewController *searchTableVC;

@end

@implementation LocationMapViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTableVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"LocationSearchTableViewController"];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchTableVC];
    [self.searchController setSearchResultsUpdater:self.searchTableVC];
    
    UISearchBar *bar = self.searchController.searchBar;
    [bar sizeToFit];
    [bar setPlaceholder:@"Search"];
    [bar setDelegate:self];
    self.navigationItem.searchController = self.searchController;
    [self.searchController setHidesNavigationBarDuringPresentation:NO];
    [self.searchController setDimsBackgroundDuringPresentation:YES];
    [self setDefinesPresentationContext:YES];
    
    [self.searchTableVC setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Location Selected Delegate (lower-layer)

- (void)locationSelected:(MKPlacemark *)placemark {
    if (delegate && [delegate respondsToSelector:@selector(locationSelected:)]) {
        [delegate locationSelected:placemark];
    } else {
        NSLog(@"Failed to call delegate");
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchTableVC.tableView setAlpha:1.0];
    [self.searchTableVC searchWithQuery:searchBar.text];
}

#pragma mark - IBActions

- (IBAction)cancelTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)currentLocationTapped:(UIButton *)sender {
    PlacesManager *places = [PlacesManager sharedManager];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:places.sharedLocation.coordinate];
    [places setSelectedNewPlacemark:placemark];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

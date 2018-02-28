//
//  LocationSearchTableViewController.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/17/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "LocationSearchTableViewController.h"

@interface LocationSearchTableViewController ()

@property CLLocationManager *locationManager;
@property NSArray<MKMapItem *>*matchingItems;
@property MKCoordinateRegion region;

@end

@implementation LocationSearchTableViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setAlpha:0.0];
    self.matchingItems = [[NSArray<MKMapItem *> alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    PlacesManager *places = [PlacesManager sharedManager];
    [self setSearchRegionWithLocation:places.sharedLocation];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityIndicatorCell" bundle:nil] forCellReuseIdentifier:@"activityIndicatorCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setSearchRegionWithLocation:(CLLocation *)location {
    if (location) {
        NSLog(@"Location is valid");
        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
        self.region = MKCoordinateRegionMake(location.coordinate, span);
    } else {
        NSLog(@"Location invalid");
    }
}

#pragma mark - Search Results Updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text.length < 1) {
        self.matchingItems = nil;
    }
}

- (void)searchWithQuery:(NSString *)searchBarText {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    [request setNaturalLanguageQuery:searchBarText];
    [request setRegion:self.region];
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        if (response) {
            self.matchingItems = response.mapItems;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.matchingItems || self.matchingItems.count == 0) {
        //activityIndicatorCell
        return 1;
    }
    return [self.matchingItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.matchingItems || self.matchingItems.count == 0) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"activityIndicatorCell"];
        return cell;
    }
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    MKPlacemark *item = self.matchingItems[indexPath.row].placemark;
    [cell.textLabel setText:item.name];
    [cell.detailTextLabel setText:[PlacesManager parseAddressFromPlacemark:item]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKPlacemark *placemark = self.matchingItems[indexPath.row].placemark;
    PlacesManager *places = [PlacesManager sharedManager];
    [places setSelectedNewPlacemark:placemark];
    [self performSegueWithIdentifier:@"unwindToModal" sender:self];
}

@end

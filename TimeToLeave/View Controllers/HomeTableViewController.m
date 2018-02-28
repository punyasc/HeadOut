//
//  HomeTableViewController.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/15/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "HomeTableViewController.h"

@interface HomeTableViewController ()

@property NSMutableArray<ETAItem *>*favorites;
@property CLLocationManager* locationManager;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableWithNotification:) name:@"RefreshTable" object:nil];
    [self refreshTableWithNotification:nil];
    [self setupLocationManager];
    [self setupBlurredNavbar];
    [PlacesManager sharedManager];
    [self modeChanged:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshTableWithNotification:nil];
}
            
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)refreshTableWithNotification:(NSNotification *)notification
{
    self.favorites = [PlacesManager getFavoritesFromStorage];
    NSLog(@"Item added, table being reloaded, %@", self.favorites);
    [self.tableView reloadData];
}

#pragma mark - Setup

- (void)setupTable {
    BVReorderTableView *reorderTable = [[BVReorderTableView alloc] init];
    [self setTableView:reorderTable];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerNib:[UINib nibWithNibName:@"ETACell" bundle:nil] forCellReuseIdentifier:@"ETACell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EmptyPlacesCell" bundle:nil] forCellReuseIdentifier:@"EmptyPlacesCell"];
}

- (void)setupLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestLocation];
}

- (void)setupBlurredNavbar {
    UIVisualEffectView *fxView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [fxView setFrame:CGRectOffset(CGRectInset(self.navigationController.navigationBar.bounds, 0, -12), 0, -60)];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar insertSubview:fxView atIndex:1];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.favorites.count == 0) {
        return 1;
    }
    return self.favorites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.favorites.count == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"EmptyPlacesCell" forIndexPath:indexPath];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETACell" forIndexPath:indexPath];
    ETACell *ecell = (ETACell *)cell;
    ETAItem *thisItem = self.favorites[indexPath.row];
    [ecell updateCellWithItem:thisItem];
    return ecell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.favorites.count == 0) {
        return 400;
    }
    return 90;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [PlacesManager removeFromFavoritesWithIndex:(NSUInteger) indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.favorites.count == 0) {
        return;
    }
    NSLog(@"Opening in Maps");
    ETACell *ecell = [tableView cellForRowAtIndexPath:indexPath];
    [NavigationLauncher openItem:ecell.item];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [PlacesManager reorderFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.firstObject) {
        PlacesManager *places = [PlacesManager sharedManager];
        [places setSharedLocation:locations.firstObject];
        [places saveUserLocation];
        NSLog(@"Location from shared: %@", places.sharedLocation);
        [self refreshTableWithNotification:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HideActivityModal" object:nil userInfo:nil];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error getting location");
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager requestLocation];
    }
}

#pragma mark - Reorder Table Delegate

- (id)saveObjectAndInsertBlankRowAtIndexPath:(NSIndexPath *)indexPath {
    ETAItem *item = self.favorites[indexPath.row];
    ETAItem *dummy = [[ETAItem alloc] init];
    [self.favorites replaceObjectAtIndex:indexPath.row withObject:dummy];
    return item;
}

- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    ETAItem *item = self.favorites[fromIndexPath.row];
    [self.favorites removeObjectAtIndex:fromIndexPath.row];
    [self.favorites insertObject:item atIndex:toIndexPath.row];
}

- (void)finishReorderingWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    [self.favorites replaceObjectAtIndex:indexPath.row withObject:object];
    [PlacesManager setFavorites:self.favorites];
}

#pragma mark - IBActions

- (IBAction)modeChanged:(UISegmentedControl *)sender {
    PlacesManager *places = [PlacesManager sharedManager];
    if (self.segmentedControl.selectedSegmentIndex) {
        [places setWalkingMode:YES];
    } else {
        [places setWalkingMode:NO];
    }
    [self.tableView reloadData];
}


@end

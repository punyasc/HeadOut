//
//  SettingsTableViewController.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/22/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self.segmentedControl setSelectedSegmentIndex:[defaults integerForKey:@"kMapMode"]];
    [self.timeSegmentedControl setSelectedSegmentIndex:[defaults boolForKey:@"kArrivalMode"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSString *mailString = @"mailto:punyasc@gmail.com?subject=TimeToGo";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString] options:@{} completionHandler:nil];
    }
}

#pragma mark - IBActions

- (IBAction)mapModeChanged:(UISegmentedControl *)sender {
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:selectedIndex forKey:@"kMapMode"];
}

- (IBAction)timeModeChanged:(UISegmentedControl *)sender {
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (selectedIndex == 0) {
        [defaults setBool:NO forKey:@"kArrivalMode"];
    } else {
        [defaults setBool:YES forKey:@"kArrivalMode"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTable" object:nil userInfo:nil];
}

- (IBAction)dismissTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

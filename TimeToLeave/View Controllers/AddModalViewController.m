//
//  AddModalViewController.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/16/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "AddModalViewController.h"

@interface AddModalViewController ()

@end

@implementation AddModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowShade" object:nil userInfo:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideShade" object:nil userInfo:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

#pragma mark - IBActions

- (IBAction)dismissTapped:(UIButton *)sender {
    PlacesManager *places = [PlacesManager sharedManager];
    [places setSelectedNewPlacemark:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


@end

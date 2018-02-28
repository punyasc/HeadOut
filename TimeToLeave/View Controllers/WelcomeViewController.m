//
//  WelcomeViewController.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/27/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "WelcomeViewController.h"



@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions

- (IBAction)startTapped:(UIButton *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"hasOnboarded"];
    [self performSegueWithIdentifier:@"showHome" sender:self];
    
}
@end

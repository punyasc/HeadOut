//
//  ETACell.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/15/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModernView.h"
#import "ETAItem.h"
#import "PlacesManager.h"
#import "NavigationLauncher.h"

@interface ETACell : UITableViewCell


@property (strong, nonatomic) IBOutlet ModernView *modernView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *destinationLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property ETAItem *item;

- (void)updateCellWithItem:(ETAItem *)item;

- (void)calculateTravelTime;

@end

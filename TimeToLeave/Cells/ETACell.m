//
//  ETACell.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/15/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "ETACell.h"


@implementation ETACell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)updateCellWithItem:(ETAItem *)item {
    if (!item.placemark) {
        [self.modernView setHidden:YES];
        [self.descriptionLabel setHidden:YES];
        return;
    } else {
        [self.modernView setHidden:NO];
        [self.descriptionLabel setHidden:NO];
    }
    [self.modernView setAlpha:0.5];
    [self.destinationLabel setText:item.destination];
    [self.iconImage setImage:item.icon];
    self.item = item;
    [self calculateTravelTime];
}

- (void)calculateTravelTime {
    PlacesManager *places = [PlacesManager sharedManager];
    MKPlacemark *startPoint = [[MKPlacemark alloc] initWithCoordinate:places.sharedLocation.coordinate];
    MKPlacemark *endPoint = [[MKPlacemark alloc] initWithCoordinate:self.item.placemark.coordinate];
    MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startPoint];
    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endPoint];

    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = startItem;
    request.destination = endItem;
    if (places.walkingMode) {
        request.transportType = MKDirectionsTransportTypeWalking;
    } else {
        request.transportType = MKDirectionsTransportTypeAutomobile;
    }
    MKDirections *direction = [[MKDirections alloc] initWithRequest:request];
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            for (MKRoute *route in response.routes) {
                NSLog(@"Distance : %f", route.distance);
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                if ([defaults boolForKey:@"kArrivalMode"]) {
                    [self.descriptionLabel setText:[PlacesManager parseArrivalTime:route.expectedTravelTime]];
                } else {
                    [self.descriptionLabel setText:[PlacesManager parseTravelTime:route.expectedTravelTime]];
                }
                [UIView animateWithDuration:0.2f delay:0.0f  options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    [self.modernView setAlpha:1.0];
                } completion:nil];
                
            }
        } else {
            NSLog(@"%@", error);
        }
    }];
}

@end

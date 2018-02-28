//
//  NavigationLauncher.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/23/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "NavigationLauncher.h"

@implementation NavigationLauncher

+ (void)openWithWaze:(ETAItem *)item {
    CLLocationCoordinate2D coord = item.placemark.coordinate;
    NSString *deepString = [NSString stringWithFormat:@"https://waze.com/ul?ll=%f,%f&navigate=yes", coord.latitude, coord.longitude];
    NSLog(@"Waze URL: %@", deepString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:deepString] options:@{} completionHandler:nil];
}

+ (void)openWithGoogleMaps:(ETAItem *)item {
    PlacesManager *places = [PlacesManager sharedManager];
    CLLocationCoordinate2D coord = item.placemark.coordinate;
    NSString *directionsMode;
    NSString *travelMode;
    if (places.walkingMode) {
        directionsMode = @"walking";
        travelMode = @"&travelmode=walking";
    } else {
        directionsMode = @"driving";
        travelMode = @"&travelmode=driving";
    }
    NSString *deepString = [NSString stringWithFormat:@"comgooglemaps://?daddr=%f,%f&directionsmode=%@", coord.latitude, coord.longitude, directionsMode];
    NSLog(@"Google URL: %@", deepString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:deepString] options:@{} completionHandler:nil];
}

+ (void)openWithAppleMaps:(ETAItem *)item {
    PlacesManager *places = [PlacesManager sharedManager];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:item.placemark];
    NSDictionary<NSString *, NSString *> *options;
    if (places.walkingMode) {
        options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
    } else {
        options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    }
    [mapItem openInMapsWithLaunchOptions:options];
}

+ (void)openItem:(ETAItem *)item {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int mapMode = (int) [defaults integerForKey:@"kMapMode"];
    switch (mapMode) {
        case 0:
            [self openWithAppleMaps:item];
            break;
        case 1:
            [self openWithGoogleMaps:item];
            break;
        case 2:
            [self openWithWaze:item];
    }
    
}

@end

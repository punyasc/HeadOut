//
//  PlacesManager.h
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/18/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ETAItem.h"
#import "HomeTableViewController.h"

@interface PlacesManager : NSObject

@property MKPlacemark *selectedNewPlacemark;
@property (readwrite) CLLocation *sharedLocation;
@property BOOL walkingMode;

+ (id)sharedManager;

+ (NSString *)parseTravelTime:(NSTimeInterval)time;

+ (NSString *)parseArrivalTime:(NSTimeInterval)time;

+ (NSString *)parseAddressFromPlacemark:(MKPlacemark *)item;

+ (NSMutableArray<ETAItem *> *)getFavoritesFromStorage;

+ (void)addToFavorites:(ETAItem *)item;

+ (void)removeFromFavoritesWithIndex:(NSUInteger)index;

+ (void)reorderFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

+ (void)setFavorites:(NSMutableArray<ETAItem *>*)newFavorites;

- (void)saveUserLocation;



@end

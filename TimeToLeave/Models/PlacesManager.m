//
//  PlacesManager.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/18/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "PlacesManager.h"

@implementation PlacesManager

+ (id)sharedManager {
    static PlacesManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        _selectedNewPlacemark = nil;
        _walkingMode = NO;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *encodedLocation = [defaults objectForKey:@"lastUserLocation"];
        _sharedLocation = [NSKeyedUnarchiver unarchiveObjectWithData:encodedLocation];
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - Parsing times and addresses

+ (NSString *)parseArrivalTime:(NSTimeInterval)time {
    NSDate *arrivalDate = [[NSDate date] dateByAddingTimeInterval:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a"];
    return [[NSString alloc] initWithFormat:@"Arrive at %@", [dateFormatter stringFromDate:arrivalDate]];
}

+ (NSString *)parseTravelTime:(NSTimeInterval)time {
    int duration = (int) time;
    int minutes = duration / 60;
    int hours = minutes / 60;
    NSString *timeString;
    if (hours > 0) {
        int extraMinutes = minutes - (hours * 60);
        char *plural = (hours == 1) ? "" : "s";
        timeString = [NSString stringWithFormat:@"%d hour%s %d minutes", hours, plural, extraMinutes];
    } else {
        char *plural = (minutes == 1) ? "" : "s";
        timeString = [NSString stringWithFormat:@"%d minute%s", minutes, plural];
    }
    
    return timeString;
}

+ (NSString *)parseAddressFromPlacemark:(MKPlacemark *)item {
    if (!item.name || [item.name isEqualToString:@""]) {
        return @"Current Location";
    }
    char *firstSpace = (item.subThoroughfare && item.thoroughfare) ? " " : "";
    char *comma = ((item.subThoroughfare || item.thoroughfare) &&
                   (item.subAdministrativeArea || item.administrativeArea)) ? ", " : "";
    char *secondSpace = (item.subAdministrativeArea && item.administrativeArea ) ? " " : "";
    NSString *addressLine = [[NSString alloc] initWithFormat:@"%@%s%@%s%@%s%@",
                             item.subThoroughfare ? : @"",
                             firstSpace,
                             item.thoroughfare ? : @"",
                             comma,
                             item.locality ? : @"",
                             secondSpace,
                             item.administrativeArea ? : @""];
    return addressLine;
}

#pragma mark - Stored array manipulation

+ (NSMutableArray<ETAItem *> *)getFavoritesFromStorage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:@"favoritePlaces"];
    NSMutableArray<ETAItem *> *itemArray = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    NSLog(@"Getting favorites from storage: %@", itemArray);
    if (!itemArray) {
        return [[NSMutableArray<ETAItem *> alloc] init];
    }
    return itemArray;
}

+ (void)addToFavorites:(ETAItem *)item {
    // Retrieve from defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedOldArray = [defaults objectForKey:@"favoritePlaces"];
    NSLog(@"Adding item %@", item);
    NSMutableArray<ETAItem *> *itemArray = [NSKeyedUnarchiver unarchiveObjectWithData:encodedOldArray];
    
    // Operate on array
    if (!itemArray) {
        itemArray = [[NSMutableArray<ETAItem *> alloc] init];
    }
    [itemArray addObject:item];
    
    // Add back to defaults
    NSData *encodedNewArray = [NSKeyedArchiver archivedDataWithRootObject:itemArray];
    [defaults setObject:encodedNewArray forKey:@"favoritePlaces"];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTable" object:nil userInfo:nil];
}

+ (void)removeFromFavoritesWithIndex:(NSUInteger)index {
    // Retrieve from defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedOldArray = [defaults objectForKey:@"favoritePlaces"];
    NSLog(@"Removing item at index: %lu", (unsigned long)index);
    NSMutableArray<ETAItem *> *itemArray = [NSKeyedUnarchiver unarchiveObjectWithData:encodedOldArray];
    
    // Operate on array
    if (!itemArray) {
        NSLog(@"No favorites to remove from");
        return;
    }
    [itemArray removeObjectAtIndex:index];
    
    // Add back to defaults
    NSData *encodedNewArray = [NSKeyedArchiver archivedDataWithRootObject:itemArray];
    [defaults setObject:encodedNewArray forKey:@"favoritePlaces"];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTable" object:nil userInfo:nil];
}

+ (void)setFavorites:(NSMutableArray<ETAItem *>*)newFavorites {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedNewArray = [NSKeyedArchiver archivedDataWithRootObject:newFavorites];
    [defaults setObject:encodedNewArray forKey:@"favoritePlaces"];
    [defaults synchronize];
}

+ (void)reorderFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
    // Retrieve from defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedOldArray = [defaults objectForKey:@"favoritePlaces"];
    NSLog(@"Removing item at index: %lu", (unsigned long)index);
    NSMutableArray<ETAItem *> *itemArray = [NSKeyedUnarchiver unarchiveObjectWithData:encodedOldArray];
    
    // Operate on array
    if (!itemArray) {
        NSLog(@"No favorites to remove from");
        return;
    }
    ETAItem *itemToMove = itemArray[from];
    [itemArray removeObjectAtIndex:from];
    [itemArray insertObject:itemToMove atIndex:to];
    
    // Add back to defaults
    NSData *encodedNewArray = [NSKeyedArchiver archivedDataWithRootObject:itemArray];
    [defaults setObject:encodedNewArray forKey:@"favoritePlaces"];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTable" object:nil userInfo:nil];
}

#pragma mark - Stored location manipulation

- (void)saveUserLocation {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedLocation = [NSKeyedArchiver archivedDataWithRootObject:self.sharedLocation];
    [defaults setObject:encodedLocation forKey:@"lastUserLocation"];
    [defaults synchronize];
}

@end

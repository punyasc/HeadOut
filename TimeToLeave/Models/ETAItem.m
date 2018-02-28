//
//  ETAItem.m
//  TimeToLeave
//
//  Created by Punya Chatterjee on 2/15/18.
//  Copyright © 2018 Punya Chatterjee. All rights reserved.
//

#import "ETAItem.h"

@implementation ETAItem

- (id)init {
    return [self initWithDestination:@" " atPlacemark:nil withIcon:nil];
}

- (id)initWithDestination:(NSString *)destination atPlacemark:(MKPlacemark *)placemark withIcon:(UIImage *)image {
    self = [super init];
    if (self) {
        _destination = destination;
        _placemark = placemark;
        _icon = image;
        _details = nil;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.destination forKey:@"destination"];
    [encoder encodeObject:self.placemark forKey:@"placemark"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.details forKey:@"details"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        _destination = [decoder decodeObjectForKey:@"destination"];
        _placemark = [decoder decodeObjectForKey:@"placemark"];
        _icon = [decoder decodeObjectForKey:@"icon"];
        _details = [decoder decodeObjectForKey:@"details"];
    }
    return self;
}

@end

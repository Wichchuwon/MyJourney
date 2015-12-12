
//
//  JourneyAnnotation.m
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/7/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import "JourneyAnnotation.h"

@implementation JourneyAnnotation
@synthesize coordinate;
@synthesize title;

-(id)initWithLocation:(CLLocationCoordinate2D) coord andTitle:(NSString *)titleOfCallout andDate:(NSDate *)date andlocationName:(NSString *)locationName{
    self = [super init];
    if(self){
        coordinate = coord;
        title = titleOfCallout;
        self.date = date;
        self.locationName = locationName;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:coordinate.latitude forKey:@"latitude"];
    [aCoder encodeDouble:coordinate.longitude forKey:@"longitude"];
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.locationName forKey:@"locationName"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        title = [aDecoder decodeObjectForKey:@"title"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.locationName = [aDecoder decodeObjectForKey:@"locationName"];
        
        CLLocationDegrees latitude = [aDecoder decodeDoubleForKey:@"latitude"];
        CLLocationDegrees longitude = [aDecoder decodeDoubleForKey:@"longitude"];
        coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}

@end

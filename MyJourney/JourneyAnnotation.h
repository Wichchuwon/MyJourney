//
//  JourneyAnnotation.h
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/7/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface JourneyAnnotation : NSObject<MKAnnotation, NSCoding>


@property(nonatomic,readonly)CLLocationCoordinate2D coordinate;
@property(nonatomic,readonly, copy)NSString *title;
@property(strong,nonatomic)NSDate *date;
@property(strong,nonatomic)NSString *locationName;


-(id)initWithLocation:(CLLocationCoordinate2D) coord andTitle:(NSString *)titleOfCallout andDate:(NSDate *)date andlocationName:(NSString *)locationName;

@end

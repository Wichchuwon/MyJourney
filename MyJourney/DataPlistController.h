//
//  DataPlistController.h
//  Journey
//
//  Created by Ariya Lawanitchanon on 12/7/2558 BE.
//  Copyright © 2558 Ariya Lawanitchanon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JourneyAnnotation;
@interface DataPlistController : NSObject

@property (nonatomic, strong) NSString *plistPath;

- (void) saveJourney: (JourneyAnnotation *) journey;
//- (void) deleteJourney: (JourneyAnnotation *) journey;
- (NSArray *) getJourneys;
-(void) saveToPlistFile:(NSArray *)journeys;
-(NSArray *) encodeAllJourneys:(NSArray *)journeys;
@end

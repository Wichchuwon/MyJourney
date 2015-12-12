//
//  MyJourneyList.h
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/9/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JourneyAnnotation;
@interface MyJourneyList : NSObject

-(id)initWithArray:(NSArray *)array;
-(void)addNewJourney:(JourneyAnnotation *)journey;
-(void)deleteJourney:(JourneyAnnotation *)journey;
- (void) sortJourneyArray;
-(NSMutableArray *) journeyList;



@end

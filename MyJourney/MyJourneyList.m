//
//  MyJourneyList.m
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/9/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import "MyJourneyList.h"
#import "JourneyAnnotation.h"

@implementation MyJourneyList {
    NSMutableArray *journeyList;
}

-(id)init {
    self = [super init];
    if (self) {
        journeyList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        journeyList = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

-(void)addNewJourney:(JourneyAnnotation *)journey {
    [journeyList addObject:journey];
}

-(void)deleteJourney:(JourneyAnnotation *)journey {
    [journeyList removeObject:journey];
}

-(NSMutableArray *) journeyList {
    return journeyList;
}

- (void) sortJourneyArray {
    //sortbydate
    NSArray *sortedArray;
    
    sortedArray = [journeyList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDate *first = [(JourneyAnnotation *)obj1 date];
        NSDate *second = [(JourneyAnnotation *)obj2 date];
        return [first compare:second];
    }];
    
    journeyList = [NSMutableArray arrayWithArray:sortedArray];
    
}

@end

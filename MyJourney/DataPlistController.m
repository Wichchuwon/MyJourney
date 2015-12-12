//
//  DataPlistController.m
//  Journey
//
//  Created by Ariya Lawanitchanon on 12/7/2558 BE.
//  Copyright © 2558 Ariya Lawanitchanon. All rights reserved.
//

#import "DataPlistController.h"
#import "JourneyAnnotation.h"

@implementation DataPlistController

- (id) init {
    self = [super init];
    if (self) {
        [self preparePlistFile];
    }
    return self;
}

- (void) preparePlistFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSString *plistPathBundle = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:plistPathBundle
                                                toPath:plistPath
                                                 error:&error];
    }

    NSLog (@"plistPath: %@", plistPath);
    
    self.plistPath = plistPath;
    
}

- (NSDictionary *) readPlistFile {
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:self.plistPath];
    NSError *errorDesc = nil;
    NSPropertyListFormat format;
    //xml=>dict
    NSDictionary *root = (NSDictionary *) [NSPropertyListSerialization propertyListWithData:plistXML
                                                                                    options:NSPropertyListMutableContainersAndLeaves
                                                                                     format:&format
                                                                                      error:&errorDesc];
    if (!root) {
        NSLog (@"Error in readPlistFile: %@", [errorDesc localizedDescription]);
    }
    return root;
}

- (NSArray *) getJourneys { //useinanotherplace
    NSArray *datas = [[self readPlistFile] objectForKey:@"journeys"];
    NSMutableArray *journeys = [[NSMutableArray alloc] init];
    
    for (NSData *data in datas) {
        [journeys addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        //decodefromdata=>objectOfjourney
    }
    
    NSLog(@"%@", journeys);
    
    return journeys;

    
}

- (NSArray *) getJourneysInNSDataFormat { //return nsdata
    NSArray *datas = [[self readPlistFile] objectForKey:@"journeys"];
    
    return datas;
}

-(void) saveToPlistFile:(NSArray *)journeys {
    NSDictionary *plistDict = [NSDictionary dictionaryWithObject:journeys
                                                          forKey:@"journeys"];
    
    
    NSError *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                                  options:NSPropertyListMutableContainersAndLeaves
                                                                    error:&error];
    //plistdict=>plistdata(XML)
    
    
    if (plistData) {
        BOOL canWrite = [plistData writeToFile:self.plistPath atomically:YES];
        NSLog (canWrite ? @"YES": @"NO");
    } else {
        NSLog (@"Error in saveData: %@", [error localizedDescription]);
    }
}

- (void) saveJourney: (JourneyAnnotation *) journey {
    NSArray *journeys = [self getJourneysInNSDataFormat];
    NSMutableArray *mutableJourneys = [NSMutableArray arrayWithArray:journeys];
    [mutableJourneys addObject:[NSKeyedArchiver archivedDataWithRootObject:journey]];
    [self saveToPlistFile:mutableJourneys];
    
}

-(NSArray *) encodeAllJourneys:(NSArray *)journeys {
    NSMutableArray *mutableJourneys = [NSMutableArray array];
    for (JourneyAnnotation *journey in journeys) {
        [mutableJourneys addObject:[NSKeyedArchiver archivedDataWithRootObject:journey]];
    }
    
    return mutableJourneys; //fordelete
}


@end

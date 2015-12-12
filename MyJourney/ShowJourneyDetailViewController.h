//
//  ShowJourneyDetailViewController.h
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/8/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyJourneyList;
@class JourneyAnnotation;
@interface ShowJourneyDetailViewController : UIViewController

@property(nonatomic,strong) NSString *message;
@property (nonatomic, strong) JourneyAnnotation *journeyAnnotation;
@property(nonatomic,strong) MyJourneyList *myJourneyList;



@end

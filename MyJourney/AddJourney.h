//
//  AddJourney.h
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/6/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class JourneyAnnotation;
@interface AddJourney : UIViewController <UIImagePickerControllerDelegate>



@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) MKMapItem *mapItem;

- (JourneyAnnotation *) getNewJourney;

@end

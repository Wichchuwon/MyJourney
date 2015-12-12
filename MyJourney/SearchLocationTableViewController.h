//
//  SearchLocationTableViewController.h
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/7/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface SearchLocationTableViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchBarDelegate>
@property (nonatomic, strong) NSArray *places;

-(MKMapItem *) getResultMapItem;

@end

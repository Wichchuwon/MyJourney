//
//  ViewController.m
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/2/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import "MapViewController.h"
#import "AddJourney.h"
#import "JourneyAnnotation.h"
#import "DataPlistController.h"
#import "ShowJourneyDetailViewController.h"
#import "MyJourneyList.h"
@import MapKit;

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property(strong,nonatomic) MKPolyline *polyline;
@property(strong,nonatomic) MKPolylineView *lineView;


@end

@implementation MapViewController {
//    NSMutableArray *journeys;
    MyJourneyList *myJourneyList;
    DataPlistController *dataPlistController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapview.delegate = self;
    [self prepareDataPlist];
    
    
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) prepareDataPlist{
    dataPlistController = [[DataPlistController alloc] init];
    myJourneyList = [[MyJourneyList alloc] initWithArray:[dataPlistController getJourneys]];
//    journeys = [NSMutableArray arrayWithArray:[dataPlistController getJourneys]];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.mapview removeAnnotations:[self.mapview annotations]];
    
    [myJourneyList sortJourneyArray];
//    journeys = [NSMutableArray arrayWithArray:[self sortJourneyArray]];

    for (JourneyAnnotation *journey in [myJourneyList journeyList]) {
        [self.mapview addAnnotation:journey];
//        [self drawLine];
    }
    [self drawLine];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if([annotation isKindOfClass:[JourneyAnnotation class]]){
        MKPinAnnotationView *pinView = (MKPinAnnotationView *) [self.mapview dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation"];
        
        if(!pinView){
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
            pinView.pinTintColor = [UIColor purpleColor];
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = rightButton;
        }else{
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
    return  nil;
}

- (void)drawLine {
    // remove polyline if one exists
    [self.mapview removeOverlay:self.polyline];
    

    
    // create an array of coordinates from allPins
    CLLocationCoordinate2D coordinates[[[myJourneyList journeyList] count]];
    int i = 0;
    for (JourneyAnnotation *currentPin in [myJourneyList journeyList]) {
        coordinates[i] = currentPin.coordinate;
        NSLog(@"success");
        i++;
    }
    
    // create a polyline with all cooridnates

    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:[[myJourneyList journeyList] count]];
    [self.mapview addOverlay:polyline];
    self.polyline = polyline;
    
}
// create an MKPolylineView and add it to the map view

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =[[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor orangeColor];
    renderer.lineWidth = 3.0;
    NSLog(@"Success22");
    
    return renderer;
}


- (IBAction)unwindFromAddJourney:(UIStoryboardSegue *)sender {
    AddJourney *addJourneyViewController = [sender sourceViewController];
    JourneyAnnotation *newJourney = [addJourneyViewController getNewJourney];
    [dataPlistController saveJourney:newJourney];
    [myJourneyList addNewJourney:newJourney];
//    [journeys addObject:newJourney];
}

-(IBAction)unwindFromShowJourneyDetailViewControllerWithDelete:(UIStoryboardSegue *)sender{
    ShowJourneyDetailViewController *sourceViewController = [sender sourceViewController];
    NSLog (@"before delete: %@", [myJourneyList journeyList]);
    [myJourneyList deleteJourney:[sourceViewController journeyAnnotation]];
    NSLog (@"after delete: %@", [myJourneyList journeyList]);
    [dataPlistController saveToPlistFile:[dataPlistController encodeAllJourneys:[myJourneyList journeyList]]];//encodealljourney

}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    [self performSegueWithIdentifier:@"showJourneyDetail" sender:view];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]isEqualToString:@"showJourneyDetail"]){
        ShowJourneyDetailViewController *detailJourney = [segue destinationViewController];
        MKAnnotationView *annotationView = sender;
        JourneyAnnotation *journeyAnnotation = (JourneyAnnotation *) [annotationView annotation];
        
        [detailJourney setJourneyAnnotation:journeyAnnotation];
        
        
    }
    
}


@end

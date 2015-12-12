//
//  AddJourney.m
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/6/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import "AddJourney.h"
#import "SearchLocationTableViewController.h"
#import "JourneyAnnotation.h"
@interface AddJourney () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;





@end

@implementation AddJourney {
    JourneyAnnotation *newJourney;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.datePicker addTarget:self
                        action:@selector(getSelectionFromDatePicker)
              forControlEvents:UIControlEventValueChanged];
  
    [self setDateLabelText];
    [self initLocationLabel];
    
    [self enableDoneButtonIfCan];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)getSelectionFromDatePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    self.dateLabel.text = [formatter stringFromDate:[self.datePicker date]];
    
}

- (void)initLocationLabel {
    self.locationLabel.text = @"";
}


- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    newJourney = [[JourneyAnnotation alloc] initWithLocation:self.mapItem.placemark.location.coordinate andTitle:self.titleTextField.text andDate:[self.datePicker date] andlocationName:[self.mapItem name]];
}

- (JourneyAnnotation *) getNewJourney {
    return newJourney;
}


- (void) setDateLabelText {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterShortStyle];
    self.dateLabel.text = [dateFormat stringFromDate:[self.datePicker date]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showSelectedLocation{
    self.locationLabel.text = self.mapItem.name;
    [self enableDoneButtonIfCan];
}


- (IBAction)unwindToAddJourneyFromSearchLocation:(UIStoryboardSegue *)sender {
    SearchLocationTableViewController *sourceViewController = [sender sourceViewController];
    self.mapItem = [sourceViewController getResultMapItem];
    
    [self showSelectedLocation];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self enableDoneButtonIfCan];
}

-(void)enableDoneButtonIfCan {
    if (![self.locationLabel.text isEqualToString:@""] && ![self.titleTextField.text isEqualToString:@""]) {
        self.doneButton.enabled = YES;
    } else {
        self.doneButton.enabled = NO;
    }
}

@end

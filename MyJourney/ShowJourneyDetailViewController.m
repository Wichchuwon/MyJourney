//
//  ShowJourneyDetailViewController.m
//  MyJourney
//
//  Created by Wichchuwon Sookchaisri on 12/8/2558 BE.
//  Copyright © 2558 Wichchuwon Sookchaisri. All rights reserved.
//

#import "ShowJourneyDetailViewController.h"
#import "JourneyAnnotation.h"
#import "MyJourneyList.h"



@interface ShowJourneyDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@end

@implementation ShowJourneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showDetail];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Disposeof any resources that can be recreated.
}

-(void)showDetail{
    self.locationLabel.text = [self.journeyAnnotation locationName];
    [self setTitle:[self.journeyAnnotation title]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterShortStyle];
    self.dateLabel.text = [dateFormat stringFromDate:[self.journeyAnnotation date]];
    }

- (IBAction)deleteButtonTapped:(id)sender {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

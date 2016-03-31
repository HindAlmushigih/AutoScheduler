//
//  NewIssueViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 22/3/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

/**
 Parameters:
 issue - A hash of the issue attributes:
 Issue (required)
 Tracker *
 Subject *
 Status *
 Priority *
 Start date *
 Due date *
  */
/**
 POST /issues.json
{
    "issue": {
        "project_id": 1,
        "subject": "Example",
        "priority_id": 4
    }
}*/

#import "NewIssueViewController.h"
#import "ASRESTAPI.h"
#import "ASUserSingleton.h"


@interface NewIssueViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *tracker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmented;
@property NSString *startDate;
@property NSString *dueDate;
@property NSString *trackerName;
@property NSNumber *trackerID;
@property NSString *priority;
@property NSNumber *priorityID;
@property (weak, nonatomic) IBOutlet UITextField *subject;

@end

@implementation NewIssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.issue = [[NSMutableDictionary alloc]init];
    self.issueDetails = [[NSMutableDictionary alloc]init];
    [self setupRangeLabel];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(IBAction) segmentedControlIndexChanged
{
    switch (self.tracker.selectedSegmentIndex)
    {
    case 0:
    self.trackerName = @"Bug";
    self.trackerID = @1;
        break;
        
    case 1:
        self.trackerName = @"Feature";
        self.trackerID = @2;
        break;
        
    case 2:
        self.trackerName = @"Support";
        self.trackerID = @3;
            break;
    }
}

// Low Normal High Urgent Immediate

-(IBAction) prioritysegmentedControlIndexChanged
{
    switch (self.prioritySegmented.selectedSegmentIndex)
    {
        case 0:
            self.priority = @"Low";
            self.priorityID = @1;
            break;
            
        case 1:
            self.priority = @"Normal";
            self.priorityID = @2;
            break;
            
        case 2:
            self.priority = @"High";
            self.priorityID = @3;
            break;
        case 3:
            self.priority = @"Urgent";
            self.priorityID = @4;
            break;
        case 4:
            self.priority = @"Immediate";
            self.priorityID = @5;
            break;
    }
}
-(void)setupRangeLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.startDate = [formatter stringFromDate:self.range.beginDate];
   // NSString *startDate = self.range.beginDate;
    [self.rangeStartDate setText:[NSString stringWithFormat:@"Start Date: %@",self.startDate]];
    self.dueDate = [formatter stringFromDate:self.range.endDate];
  //  NSString *dueDate = self.range.endDate;
    [self.rangeDueDate setText:[NSString stringWithFormat:@"Due Date: %@",self.dueDate]];
}

- (IBAction)save:(id)sender
{
//    
  NSString* errorMessage = @"";
    if ([self.subject.text length] == 0) {
     errorMessage = @"Check the empty field";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:errorMessage
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                  NSLog(@"You pressed OK");
                                                              }];
        [alert addAction:firstAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {

        NSString* username = [[ASUserSingleton sharedInstance]userName];
        NSString* password = [[ASUserSingleton sharedInstance]password];
        [ASRESTAPI creatIssueUsername:username andPassword:password andIssue:[self createIssueObj]];
        [self.navigationController dismissViewControllerAnimated:NO
                                                      completion:nil];
    }
}

/**
 Parameters:
 issue - A hash of the issue attributes:
 Issue (required)
 Project_id
 Tracker_id
 Status_id
 Priority_id
 Tracker *
 Subject *
 Status *
 Priority *
 Start date *
 Due date *
 */

-(NSMutableDictionary*)createIssueObj
{
    self.issueDetails = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInt:1], @"project_id",
                         self.trackerID, @"tracker_id",
                         self.priorityID, @"priority_id",
                         [NSNumber numberWithInt:1], @"status_id",
                         self.subject.text, @"subject",
                         self.startDate, @"start_date",
                         self.dueDate, @"due_date",
                         nil];
    self.issue[@"issue"] = self.issueDetails;
    return self.issue;
}

- (IBAction)cancel:(id)sender {
    [self.navigationController dismissViewControllerAnimated:NO
                                                  completion:nil];
}

@end

//
//  IssueDetailsViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 22/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

/*
 {
 "issue":
 {
 "id":1,
 "project":{"id":1,"name":"test"},
 "tracker":{"id":1,"name":"Bug"},
 "status":{"id":1,"name":"New"},
 "priority":{"id":4,"name":"Urgent"},
 "author":{"id":1,"name":"Redmine Admin"},
"subject":"Example",
"description":"",
 "start_date":"2016-02-17",
 "due_date":"2016-02-23",
 "done_ratio":0,
 "estimated_hours":3.0,
 "spent_hours":0.0,
 "created_on":"2016-02-18T04:28:55Z",
 "updated_on":"2016-02-22T19:09:22Z"
 }
 }
 
 */

#import "IssueDetailsViewController.h"

@interface IssueDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *projectNametextLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackerNametextLabel;
@property (weak, nonatomic) IBOutlet UILabel *issueStatustextLabel;
@property (weak, nonatomic) IBOutlet UILabel *issuePrioritytextLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjecttextLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorNametextLabel;
@property (weak, nonatomic) IBOutlet UILabel *start_datetextLabel;
@property (weak, nonatomic) IBOutlet UILabel *due_datetextLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimated_hourstextLabel;
@property (weak, nonatomic) IBOutlet UILabel *created_ontextLabel;
@property (weak, nonatomic) IBOutlet UILabel *updated_ontextLabel;
@end

@implementation IssueDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUptTheLabels];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUptTheLabels

{
    _projectNametextLabel.text = [@"Project Name: " stringByAppendingString: _issue[@"project"][@"name"]];
    _trackerNametextLabel.text = [@"Tracker Name: " stringByAppendingString: _issue[@"tracker"][@"name"]];
    _issueStatustextLabel.text = [@"Project Status: " stringByAppendingString: _issue[@"status"][@"name"]];
    _issuePrioritytextLabel.text = [@"Priority Name: " stringByAppendingString:_issue[@"priority"][@"name"]];
    _subjecttextLabel.text = [@"Subject: " stringByAppendingString: [_issue objectForKey:@"subject"]];
    _authorNametextLabel.text = [@"Auther Name: " stringByAppendingString: _issue[@"author"][@"name"]];
    _start_datetextLabel.text = [@"Start Date: " stringByAppendingString:[_issue objectForKey:@"start_date"]];
    _due_datetextLabel.text = [@"Due Date: " stringByAppendingString:[_issue objectForKey:@"due_date"]];
//    if ([_issue[@"estimated_hours"] isKindOfClass:[NSNull class]]) {
//        _estimated_hourstextLabel.text = @"Estimated hours: ";
//    }
//    else
//    {
//    _estimated_hourstextLabel.text = [@"Estimated hours: " stringByAppendingString:[_issue objectForKey:@"estimated_hours"]];
//    }
    _created_ontextLabel.text = [@"Created On: " stringByAppendingString: [_issue objectForKey:@"created_on"]];
    _updated_ontextLabel.text = [@"Updated On: " stringByAppendingString:[_issue objectForKey:@"updated_on"]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backToGantt:(id)sender {
  //  NSLog(@"This is the view that presened this view", self.presentedViewController);
      [self dismissViewControllerAnimated:YES completion:nil]; // or popToRoot... if required.
}


@end

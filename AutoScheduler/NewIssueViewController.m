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
 Description *
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

@end

@implementation NewIssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.issue = [[NSMutableDictionary alloc]init];
    self.issueDetails = [[NSMutableDictionary alloc]init];
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

@end

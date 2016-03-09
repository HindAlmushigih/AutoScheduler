//
//  GanttChartViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 7/3/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "GanttChartViewController.h"
#import "ASRESTAPI.h"
#import "ASUserSingleton.h"
#import "IssuesObj.h"
#import "IQGanttView.h"
@interface GanttChartViewController ()

@end

@implementation GanttChartViewController
{
    NSArray *issuesItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    issuesItems = [[NSArray alloc] init];
    self.ganttView = [[IQGanttView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.ganttView];
    [self setupLoadingIndicator];
    // Do any additional setup after loading the
    [self gettheIssuesItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupLoadingIndicator
{
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(65, 40, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"Loading...";
    [loadingView addSubview:loadingLabel];
    [self.ganttView addSubview:loadingView];
    [activityView startAnimating];
}

-(void)gettheIssuesItems
{
    
    NSString* username = [[ASUserSingleton sharedInstance]userName];
    NSString* password = [[ASUserSingleton sharedInstance]password];
    _issues = nil;
    [ASRESTAPI issuesListUsername:username andPassword:password completionBlock:^(NSDictionary *response, NSArray *issueArray) {
        _issues = response;
        issuesItems = issueArray;
        
        NSMutableArray *issuesObjs = [NSMutableArray array];
        int i;
        for (i =0; i < issuesItems.count;i++)
        {
            /*_issues[@"project"][@"name"]*/ // this is how to call the dictionary object from the array
            IssuesObj* issuesObj = [[IssuesObj alloc]initWithProjectName:issuesItems[i][@"project"][@"name"]
                                                               startDate:issuesItems[i][@"start_date"]
                                                                 dueDate:issuesItems[i][@"due_date"]
                                                          estimatedhours:issuesItems[i][@"estimated_hours"]];
            //issuesItems[i] objectForKey:@"project"];
            [issuesObjs addObject:issuesObj];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityView stopAnimating];
            [loadingView removeFromSuperview];
            for (IssuesObj* issuesObj in issuesObjs) {
                [self.ganttView addRow:issuesObj];
            }
            
        });
        
    }];
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

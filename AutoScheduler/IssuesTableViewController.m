//
//  IssuesTableViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 21/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "IssuesTableViewController.h"
#import "ASRESTAPI.h"
#import "ASUserSingleton.h"
#import "IssueDetailsViewController.h"
#import "GLCalendarViewController.h"
/*
 {
 author =     {
 id = 1;
 name = "Redmine Admin";
 };
 "created_on" = "2016-02-22T00:43:51Z";
 description = "";
 "done_ratio" = 0;
 id = 2;
 priority =     {
 id = 2;
 name = Normal;
 };
 project =     {
 id = 2;
 name = test2;
 };
 "start_date" = "2016-02-21";
 status =     {
 id = 1;
 name = New;
 };
 subject = newissue;
 tracker =     {
 id = 1;
 name = Bug;
 };
 "updated_on" = "2016-02-22T00:43:51Z";
 }

 */

@interface IssuesTableViewController ()

@end

@implementation IssuesTableViewController
{
    NSArray *issuesItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    issuesItems = [[NSArray alloc] init];
    [self gettheIssuesItems];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return [issuesItems count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *tempDictionary= [issuesItems objectAtIndex:indexPath.row];
    
   // NSString *projectname = tempDictionary[@"project"][@"name"];
    
    cell.textLabel.text = tempDictionary[@"project"][@"name"]; // projectname;//[tempDictionary objectForKey:@"name"];
    cell.detailTextLabel.text = [tempDictionary objectForKey:@"subject"];;    // Configure the cell...
   // CGRect frame = CGRectMake(4.0f, 4.0f, size.width, size.height);
    cell.detailTextLabel.frame = CGRectMake(20,241,560,21);
    return cell;
}

-(void)gettheIssuesItems
{
    NSString* username = [[ASUserSingleton sharedInstance]userName];
    NSString* password = [[ASUserSingleton sharedInstance]password];
    _issues = nil;
    [ASRESTAPI issuesListUsername:username andPassword:password completionBlock:^(NSDictionary *response, NSArray *issueArray) {
        _issues = response;
        issuesItems = issueArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showIssueDetails"])
    {

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    IssueDetailsViewController *detailViewController = (IssueDetailsViewController *)segue.destinationViewController;
    detailViewController.issue = [issuesItems objectAtIndex:indexPath.row];
    }
        if ([[segue identifier] isEqualToString:@"CreateNewIssue"])
        {
            GLCalendarViewController* nvc = (GLCalendarViewController *)segue.destinationViewController;
        }
    
}

@end

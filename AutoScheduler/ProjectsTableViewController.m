//
//  ProjectsTableViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 21/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "ProjectsTableViewController.h"
#import "ASRESTAPI.h"
#import "ASUserSingleton.h"
#import "ProjectDetailsViewController.h"
#import "NewProjectViewController.h"
#import "ProjectModulesTableViewController.h"


@interface ProjectsTableViewController ()

@end

@implementation ProjectsTableViewController
{
    NSArray *projectsItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    projectsItems = [[NSArray alloc] init];
    [self gettheProjectsItems];
    
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
    return [projectsItems count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *tempDictionary= [projectsItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tempDictionary objectForKey:@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"View Project..."];
    // Configure the cell...
    cell.detailTextLabel.frame = CGRectMake(20,241,560,21);
    
    return cell;
}


-(void)gettheProjectsItems
{
    NSString* username = [[ASUserSingleton sharedInstance]userName];
    NSString* password = [[ASUserSingleton sharedInstance]password];
    _projects = nil;
    [ASRESTAPI projectsListUsername:username andPassword:password completionBlock:^(NSDictionary *response, NSArray *projectArray) {
        _projects = response;
        projectsItems = projectArray;
       // [self.tableView reloadData];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"ShowSelectedProject"])
    {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
    ProjectModulesTableViewController *projectModules = (ProjectModulesTableViewController *)segue.destinationViewController;
    projectModules.project = [projectsItems objectAtIndex:indexPath.row];
    } else if ([[segue identifier] isEqualToString:@"CreateNewProject"])
    {
        NewProjectViewController* nvc = (NewProjectViewController *)segue.destinationViewController;
        
    }

}


@end

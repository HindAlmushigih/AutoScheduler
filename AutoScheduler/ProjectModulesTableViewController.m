//
//  ProjectModulesTableViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 19/4/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "ProjectModulesTableViewController.h"
#import "ProjectDetailsViewController.h"
#import "IssuesTableViewController.h"
#import "GanttChartViewController.h"
@interface ProjectModulesTableViewController ()

@end

@implementation ProjectModulesTableViewController
{
    NSArray *projectModules;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    projectModules = @[@"Project Details", @"Issues", @"Gantt-Chart"];
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
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return projectModules.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [projectModules objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger row = indexPath.row;
   // NSInteger section = indexPath.section;
        //int indexPathint = (int)indexPath;
    switch (row) {
        case 0:
        {
            ProjectDetailsViewController *detailViewController = (ProjectDetailsViewController *)segue.destinationViewController;
            detailViewController.project = self.project;
        }
            break;
        
        case 1:
        {
            IssuesTableViewController *issuesTableViewController = (IssuesTableViewController *)segue.destinationViewController;
            issuesTableViewController.project = self.project;
        }
            break;
            
        case 2:
        {
            GanttChartViewController *ganttChartViewController = (GanttChartViewController *)segue.destinationViewController;
            ganttChartViewController.project = self.project;
        }
            break;
}
//        if(indexPathint == 0)
//        {
//        ProjectDetailsViewController *detailViewController = (ProjectDetailsViewController *)segue.destinationViewController;
//        detailViewController.project = self.project;
//        }
//        if(indexPathint == 1)
//        {
//            IssuesTableViewController *issuesTableViewController = (IssuesTableViewController *)segue.destinationViewController;
//            issuesTableViewController.project = self.project;
//        }
//        if(indexPathint == 2)
//        {
//            GanttChartViewController *ganttChartViewController = (GanttChartViewController *)segue.destinationViewController;
//            ganttChartViewController.project = self.project;
//        }
    

}


@end

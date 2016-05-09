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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return projectModules.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [projectModules objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger row = indexPath.row;

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
}


@end

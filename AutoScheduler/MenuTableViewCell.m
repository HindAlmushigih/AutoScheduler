//
//  MenuTableViewCell.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell
{
    NSArray *menuItems;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    menuItems = @[@"Home", @"Projects", @"Issues", @"GanntChart", @"Calendar", @"Notification", @"Auto-Scheduler"];
}
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // configure the destination view controller:
    if ( [sender isKindOfClass:[UITableViewCell class]] )
    {
       // UILabel* c = [(SWUITableViewCell *)sender label];
//        UINavigationController *navController = segue.destinationViewController;
//        ColorViewController* cvc = [navController childViewControllers].firstObject;
//        if ( [cvc isKindOfClass:[ColorViewController class]] )
//        {
//            cvc.color = c.textColor;
//            cvc.text = c.text;
//        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
//    static NSString *CellIdentifier = @"Cell";
//    
//    switch ( indexPath.row )
//    {
//        case 0:
//            CellIdentifier = @"Home";
//            break;
//            
//        case 1:
//            CellIdentifier = @"Projects";
//            break;
//            
//        case 2:
//            CellIdentifier = @"Issues";
//            break;
//        case 3:
//            CellIdentifier = @"GanntChart";
//            break;
//        case 4:
//            CellIdentifier = @"Calendar";
//            break;
//        case 5:
//            CellIdentifier  = @"Notification";
//            break;
//        case 6:
//            CellIdentifier = @"Auto-Scheduler";
//            break;
//
//    }
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
//    
//    return cell;
}

#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO call whatever function you need to visually restore
}

@end

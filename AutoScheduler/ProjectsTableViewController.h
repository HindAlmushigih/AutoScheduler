//
//  ProjectsTableViewController.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 21/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property NSDictionary* projects;

@end

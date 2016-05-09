//
//  NewIssueViewController.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 22/3/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLCalendarDateRange.h"

@interface NewIssueViewController : UIViewController

@property NSMutableDictionary* issue;
@property NSMutableDictionary* issueDetails;
@property GLCalendarDateRange *range;
@property NSDictionary* project;

@property (weak, nonatomic) IBOutlet UILabel *rangeStartDate;
@property (weak, nonatomic) IBOutlet UILabel *rangeDueDate;

-(IBAction) segmentedControlIndexChanged;
-(IBAction) prioritysegmentedControlIndexChanged;

@end

//
//  GanttChartViewController.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 7/3/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQGanttView.h"
#import "LoadingView.h"

/*!
 * @discussion GanttChartViewController is UIViewController. The view will add IQGanttView as a subview.
 */


@interface GanttChartViewController : UIViewController

@property (nonatomic, retain) LoadingView *loadingView;

@property NSDictionary* project;
@property NSDictionary* issues;
//@property (strong, nonatomic) IQGanttView *ganttView;
@property (strong, nonatomic) IQGanttView *ganttView;
//@property (strong, nonatomic) IBOutlet IQGanttView *ganttView;
-(NSDate*)stringToDate:(NSString*)dateStr;
-(CGRect)numOfItemToSetFrameSize:(NSArray*)item;
@end

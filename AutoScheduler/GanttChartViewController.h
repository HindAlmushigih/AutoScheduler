//
//  GanttChartViewController.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 7/3/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQGanttView.h"

@interface GanttChartViewController : UIViewController
{
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    UILabel *loadingLabel;
}
@property (nonatomic, retain) UIActivityIndicatorView * activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;


@property NSDictionary* issues;
@property (strong, nonatomic) IQGanttView *ganttView;

-(NSDate*)stringToDate:(NSString*)dateStr;
@end

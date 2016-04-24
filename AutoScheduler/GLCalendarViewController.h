//
//  GLCalendarViewController.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 22/3/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLCalendarView.h"
#import "GLCalendarDateRange.h"
#import "GLDateUtils.h"
#import "GLCalendarDayCell.h"
@interface GLCalendarViewController : UIViewController <GLCalendarViewDelegate>
@property NSDictionary* project;

@end


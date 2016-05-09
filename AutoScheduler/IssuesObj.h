//
//  IssuesObj.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 7/3/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IQCalendarDataSource.h"

@interface IssuesObj : NSObject <IQCalendarDataSource>

/**
 "issue":
 {
 "id":1,
 "project":{"id":1,"name":"test"},
 "tracker":{"id":1,"name":"Bug"},
 "status":{"id":1,"name":"New"},
 "priority":{"id":4,"name":"Urgent"},
 "author":{"id":1,"name":"Redmine Admin"},
 "subject":"Example",
 "description":"",
 "start_date":"2016-02-17",
 "due_date":"2016-02-23",
 "done_ratio":0,
 "estimated_hours":3.0,
 "spent_hours":0.0,
 "created_on":"2016-02-18T04:28:55Z",
 "updated_on":"2016-02-22T19:09:22Z"
 }
 */

@property (nonatomic, strong) NSString* projectName;
@property (nonatomic, strong) NSDate* start_date;
@property (nonatomic, strong) NSDate* due_date;
@property (nonatomic, strong) NSNumber* estimated_hours;

-(id)initWithProjectName:(NSString*)projectName startDate:(NSDate*)start_date dueDate:(NSDate*)due_date estimatedhours:(NSNumber*)estimated_hours;







@end
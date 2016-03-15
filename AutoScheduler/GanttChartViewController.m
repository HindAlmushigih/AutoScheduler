//
//  GanttChartViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 7/3/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "GanttChartViewController.h"
#import "ASRESTAPI.h"
#import "ASUserSingleton.h"
#import "IssuesObj.h"
#import "IQGanttView.h"

@interface CalendarEntry : NSObject <IQCalendarSimpleDataItem> {
    NSDate* start, *end;
    NSString* text;
}

+ (CalendarEntry*) entryWithText:(NSString*)text start:(NSDate*)s end:(NSDate*)end;
- (NSObject<IQCalendarActivity>*) value;
- (NSDate*) startDate;
- (NSDate*) endDate;

@end

@implementation CalendarEntry
+ (CalendarEntry*) entryWithText:(NSString*)text start:(NSDate*)s end:(NSDate*)e
{
    CalendarEntry* ent = [[CalendarEntry alloc] init];
    if(ent == nil) return nil;
    ent->start = s;
    ent->end = e;
    ent->text = text;
    return ent;
}
- (NSObject<IQCalendarActivity>*) value {
    return (NSObject<IQCalendarActivity>*)text;
}
- (NSDate*) startDate {
    return start;
}
- (NSDate*) endDate {
    return end;
}
- (UIColor*) color {
    return [UIColor redColor];
}
@end

@interface GanttChartViewController ()

@end

@implementation GanttChartViewController
{
    NSArray *issuesItems;
    CalendarEntry* ent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    issuesItems = [[NSArray alloc] init];
    self.ganttView = [[IQGanttView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.ganttView];
   // [self setupLoadingIndicator];
    // Do any additional setup after loading the
    [self gettheIssuesItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupLoadingIndicator
{
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(65, 40, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"Loading...";
    [loadingView addSubview:loadingLabel];
    [self.ganttView addSubview:loadingView];
    [activityView startAnimating];
}

-(void)gettheIssuesItems
{
    
    NSString* username = [[ASUserSingleton sharedInstance]userName];
    NSString* password = [[ASUserSingleton sharedInstance]password];
    _issues = nil;
    [ASRESTAPI issuesListUsername:username andPassword:password completionBlock:^(NSDictionary *response, NSArray *issueArray) {
        _issues = response;
        issuesItems = issueArray;
        
        NSMutableArray *issuesObjs = [NSMutableArray array];
        NSMutableSet* items = [NSMutableSet set];
        int i;
        for (i =1; i <= [issuesItems count];i++)
        {
            /*_issues[@"project"][@"name"]*/ // this is how to call the dictionary object from the array
            IssuesObj* issuesObj = [[IssuesObj alloc]initWithProjectName:issuesItems[i-1][@"subject"]//[@"project"][@"name"]
                                                               startDate:issuesItems[i-1][@"start_date"]
                                                                 dueDate:issuesItems[i-1][@"due_date"]
                                                          estimatedhours:issuesItems[i-1][@"estimated_hours"]];

            
            [issuesObjs addObject:issuesObj];
            NSDate* start_date  = [self stringToDate:issuesItems[i-1][@"start_date"]];
            NSDate* due_date  = [self stringToDate:issuesItems[i-1][@"due_date"]];
            [items addObject:[CalendarEntry
                              entryWithText:issuesItems[i-1][@"subject"]
                              start:start_date
                              end: due_date]];
        }
                    [self.ganttView addRow:[IQCalendarSimpleDataSource dataSourceWithSet:items]];
        
        
//        [items addObject:[CalendarEntry entryWithText:@"Issue" start:[NSDate dateWithTimeIntervalSinceReferenceDate:issuesItems[i-1][@"start_date"]] end:[NSDate dateWithTimeIntervalSinceReferenceDate:issuesItems[i-1][@"due_date"]]]];
//        [self.ganttView addRow:[IQCalendarSimpleDataSource dataSourceWithSet:items]];
        
        /*dispatch_async(dispatch_get_main_queue(), ^{
            [activityView stopAnimating];
            for (loadingView in [self.ganttView subviews])
            {
                [loadingView removeFromSuperview];
            }
            //[loadingView removeFromSuperview];
//            for (IssuesObj* issuesObj in issuesObjs) {
//                [self.ganttView addRow:issuesObj];
//            }
            
        });*/
        
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSDate*)stringToDate:(NSString*)dateStr{
    if ([dateStr isKindOfClass:[NSDate class]]) {
        return (NSDate*)dateStr;
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    return date;
}

@end

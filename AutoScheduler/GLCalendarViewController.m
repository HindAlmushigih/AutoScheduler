//
//  GLCalendarViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 22/3/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "GLCalendarViewController.h"
#import "GLCalendarView.h"
#import "GLCalendarDateRange.h"
#import "GLDateUtils.h"
#import "GLCalendarDayCell.h"
#import "NewIssueViewController.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GLCalendarViewController ()<GLCalendarViewDelegate>
@property (weak, nonatomic) IBOutlet GLCalendarView *calendarView;

@property (nonatomic, weak) GLCalendarDateRange *rangeUnderEdit;
@property GLCalendarDateRange *range;
@end

@implementation GLCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.view addSubview:self.calendarView];
    self.calendarView.delegate = self;
    self.calendarView.showMagnifier = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.calendarView reload];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.calendarView scrollToDate:self.calendarView.lastDate animated:NO];
    });
}

- (BOOL)calenderView:(GLCalendarView *)calendarView canAddRangeWithBeginDate:(NSDate *)beginDate
{
    return YES;
}

- (GLCalendarDateRange *)calenderView:(GLCalendarView *)calendarView rangeToAddWithBeginDate:(NSDate *)beginDate
{
    NSDate* endDate = [GLDateUtils dateByAddingDays:3 toDate:beginDate];
    self.range = [GLCalendarDateRange rangeWithBeginDate:beginDate endDate:endDate];
    self.range.backgroundColor = [UIColor purpleColor]; //UIColorFromRGB(0x80ae99);
    self.range.editable = YES;
    return self.range;
}

- (void)calenderView:(GLCalendarView *)calendarView beginToEditRange:(GLCalendarDateRange *)range
{
    NSLog(@"begin to edit range: %@", range);
    self.rangeUnderEdit = range;
}

- (void)calenderView:(GLCalendarView *)calendarView finishEditRange:(GLCalendarDateRange *)range continueEditing:(BOOL)continueEditing
{
    NSLog(@"finish edit range: %@", range);
    self.rangeUnderEdit = nil;
}

- (BOOL)calenderView:(GLCalendarView *)calendarView canUpdateRange:(GLCalendarDateRange *)range toBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate
{
    return YES;
}

- (void)calenderView:(GLCalendarView *)calendarView didUpdateRange:(GLCalendarDateRange *)range toBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate
{
    NSLog(@"did update range: %@", range);
}

- (IBAction)nextButtonPressed:(id)sender
{
//    self.range;
}

- (IBAction)cancel:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:NO
                                                  completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"NewIssueWind"])
    {
        if (self.range == nil)
        {
            NSString* errorMessage = @"";
            errorMessage = @"Please choose a range";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                           message:errorMessage
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                      NSLog(@"You pressed OK");
                                                                  }];
            [alert addAction:firstAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
        UINavigationController *navController = (UINavigationController*)[segue destinationViewController];

        NewIssueViewController* nvc = [navController topViewController]; //(NewIssueViewController *)segue.destinationViewController;
        
        nvc.range = [GLCalendarDateRange rangeWithBeginDate:self.range.beginDate endDate:self.range.endDate];// self.range;
        }
    }
    
}

@end

//
//  IQCalendarDataSource.m
//  IQWidgets for iOS
//
//  Copyright 2011 EvolvIQ
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "IQCalendarDataSource.h"


@interface IQCalendarSimpleDataSource () {
    NSObject<NSFastEnumeration>* data;
    NSString* labelText;
}
@end

@implementation IQCalendarSimpleDataSource
@synthesize labelText, themeClassName;
@synthesize startDateCallback, endDateCallback, valueCallback;

+ (IQCalendarSimpleDataSource*) dataSourceWithLabel:(NSString*)label set:(NSSet*)items
{
    IQCalendarSimpleDataSource* ds = [[IQCalendarSimpleDataSource alloc] initWithSet:items];
    ds.labelText = label;
    return ds;
}
+ (IQCalendarSimpleDataSource*) dataSourceWithLabel:(NSString*)label array:(NSArray*)items
{
    IQCalendarSimpleDataSource* ds = [[IQCalendarSimpleDataSource alloc] initWithArray:items];
    ds.labelText = label;
    return ds;
}

+ (IQCalendarSimpleDataSource*) dataSourceWithSet:(NSSet*)items
{
    IQCalendarSimpleDataSource* ds = [[IQCalendarSimpleDataSource alloc] initWithSet:items];
    return ds;
}

+ (IQCalendarSimpleDataSource*) dataSourceWithArray:(NSArray*)items
{
    IQCalendarSimpleDataSource* ds = [[IQCalendarSimpleDataSource alloc] initWithArray:items];
    return ds;
}

- (id) initWithSet:(NSSet*)items
{
    self = [super init];
    if(self != nil) {
        self->data = items;
    }
    return self;
}

- (id) initWithArray:(NSArray*)items
{
    self = [super init];
    if(self != nil) {
        self->data = items;
    }
    return self;
}

#pragma mark Key/value coding


- (void) setKeysForStartDate:(SEL)startDateSel endDate:(SEL)endDateSel
{
    {
        self.startDateCallback = ^(id item) {
            NSDate* date = [item performSelector:startDateSel withObject:item];
            return [date timeIntervalSinceReferenceDate];
        };
         self.endDateCallback = ^(id item) {
             NSDate* date = [item performSelector: endDateSel withObject:item];
            return [date timeIntervalSinceReferenceDate];
        };
    }
//    self.startDateCallback = ^(id item) {
//        NSDate* date = [item performSelector:startDateSel withObject:[endDateSel ]
//                        <#(NSTimeInterval)#> valueForKey:startDateKey];
//        return [date timeIntervalSinceReferenceDate];
//    };
//    self.endDateCallback = ^(id item) {
//        NSDate* date = [item valueForKey:endDateKey];
//        return [date timeIntervalSinceReferenceDate];
//    };
}

- (void) setKeyForValue:(NSString*)valueKey
{
    self.valueCallback = ^(id item) {
        return [item valueForKey:valueKey];
    };
}


#pragma mark IQCalendarDataSource implementation

- (void) enumerateEntriesUsing:(IQCalendarDataSourceEntryCallback)enumerator from:(NSTimeInterval)startTime to:(NSTimeInterval)endTime
{
    if(startDateCallback == nil || endDateCallback == nil) {
        [self setKeysForStartDate:@selector(startDate) endDate:@selector(endDate)];
        //[self setSelectorsForStartDate:@selector(startDate) endDate:@selector(endDate)];
        
        
        //startDateCallback = items.startDate.value;
        
        //[self setKeysForStartDate:startDate endDate:endDate];
        //[self setSelectorsForStartDate:@selector(startDate) endDate:@selector(endDate)];
        
    }
    IQCalendarDataSourceTimeExtractor start = startDateCallback;
    IQCalendarDataSourceTimeExtractor end = endDateCallback;
    IQCalendarDataSourceValueExtractor value = valueCallback;
    
    if(!value && (start || end)) {
        value = ^(id item) {
            if([item respondsToSelector:@selector(value)]) {
                return (NSObject<IQCalendarActivity>*)[(id<IQCalendarSimpleDataItem>)item value];
            } else {
                return (NSObject<IQCalendarActivity>*)nil;
            }
        };
    }
    __block NSTimeInterval ttstart = 0.0;
    if(!start) {
        start = ^(id item) {
            NSDate* date = [(id<IQCalendarSimpleDataItem>)item startDate];
            ttstart = [date timeIntervalSinceReferenceDate];
            return ttstart; //[date timeIntervalSinceReferenceDate];
        };
    }
    __block NSTimeInterval ttend = 0.0;
    if(!end) {
        end = ^(id item) {
            NSDate* date = [(id<IQCalendarSimpleDataItem>)item endDate];
            ttend = [date timeIntervalSinceReferenceDate];
            return ttend; //[date timeIntervalSinceReferenceDate];
        };
    }
    
    for(id item in (id<NSFastEnumeration>)data) {
        NSTimeInterval tstart = startDateCallback(item); //ttstart; //startDateCallback(item);
        if(tstart < endTime) {
            NSTimeInterval tend = endDateCallback(item); //ttend;//endDateCallback(item);
            if(tend > startTime) {
                NSObject<IQCalendarActivity>* activityValue = nil;
                if(value != nil) activityValue = value(item);
                enumerator(tstart, tend, activityValue);
            }
        }
    }
}

@end

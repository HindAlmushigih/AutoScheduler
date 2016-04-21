//
//  ASRESTAPI.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASUserSingleton.h"

@interface ASRESTAPI : NSObject

@property NSURL* redmineServer;
@property NSMutableURLRequest *request;

+(ASRESTAPI*)sharedInstance;

+ (BOOL)logging ;

+ (void)setLogging:(BOOL)newValue;

+(void)loginToASWithusername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(BOOL response))completion;

+(void)currentUsername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(NSDictionary* response))completion;

+(void)projectsListUsername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(NSDictionary* response, NSArray* projectArray))completion;

+(void)creatProjectUsername:(NSString*)username andPassword:(NSString*)password andProject:(NSDictionary*)project;

+(void)issuesListUsername:(NSString*)username andPassword:(NSString*)password forProjectName:(NSString*)projectname completionBlock:(void(^)(NSDictionary* response, NSArray* issueArray))completion;

+(void)creatIssueUsername:(NSString*)username andPassword:(NSString*)password andIssue:(NSDictionary*)issue;
@end

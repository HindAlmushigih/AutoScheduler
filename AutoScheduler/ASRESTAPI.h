//
//  ASRESTAPI.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASUserSingleton.h"

@interface ASRESTAPI : NSObject <NSURLSessionDelegate>

@property NSString *redmineURL;

/*!
 * @discussion A method to returns a shared singleton ASRESTAPI object.
 * @return a static ASRESTAPI object
 */
+(ASRESTAPI*)sharedInstance;

+ (BOOL)logging ;



+ (void)setLogging:(BOOL)newValue;

/*!
 * @discussion A method to set the URL of redmine server to store it in NSUserDefults object The URL must end up by "/"
 * @param redmineURL The URL string for redmine server
 */
-(void)setRedmineURL:(NSString *)redmineURL;

/*!
 * @discussion A method to returen the URL to redmine server that was stored in NSUserDefults object.
 * @return The URL string for redmine server
 */
-(NSString*)redmineURL;

/*!
 * @discussion A login method for the registered user to login to redmine
 * @param username NSString to be used.
 * @param password The password the user account.
 * @param completion A completionBlock:(void(^)(BOOL response))completion
 * The API will try to login for the user to redmine server and the block will return a Boolean value if the login is successful or not.
 */

+(void)loginToASWithusername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(BOOL response))completion;

/*!
 * @discussion A method to returen the current user information after login
 * @param username NSString to be used.
 * @param password The password the user account.
 * @param completion A completionBlock:(void(^)(NSDictionary* response))completion
 * The API will try to get the current user information after from redmine server and the block will return am NSDictionary value that contain the user information.
 */

+(void)currentUsername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(NSDictionary* response))completion;

/*!
 * @discussion A method to returen the projects list on redmine server.
 * @param username NSString to be used.
 * @param password The password the user account.
 * @param completion A completionBlock:(void(^)(NSDictionary* response))completion
 * The API will try to get the projects list on redmine server and the block will return an NSDictionary value that contain all the project list on redmine server.
 */

+(void)projectsListUsername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(NSDictionary* response, NSArray* projectArray))completion;

/*!
 * @discussion A method to create the projects and post in redmine server.
 * @param username NSString to be used.
 * @param password The password the user account.
 * @param project NSDictionary value that contain all the project details to post into redmine server.
 */

+(void)createProjectUsername:(NSString*)username andPassword:(NSString*)password andProject:(NSDictionary*)project;

/*!
 * @discussion A method to returen the issue list on redmine server for a specific project.
 * @param username NSString to be used.
 * @param password The password the user account.
 * @param completion A completionBlock:(void(^)(NSDictionary* response, NSArray* issueArray))completion
 * The API will try to get the issue list on redmine server for  and the block will return an NSDictionary value that contain all the issue list on redmine server for a project.
 */

+(void)issuesListUsername:(NSString*)username andPassword:(NSString*)password forProjectName:(NSString*)projectname completionBlock:(void(^)(NSDictionary* response, NSArray* issueArray))completion;

/*!
 * @discussion A method to create the Issue for a specific project and post in redmine server.
 * @param username NSString to be used.
 * @param password The password the user account.
 * @param projectname the project name
 * @param issue NSDictionary value that contain all the issue details to post into redmine server for a project.
 */

+(void)createIssueUsername:(NSString*)username andPassword:(NSString*)password forProjectName:(NSString*)projectname andIssue:(NSDictionary*)issue;
@end

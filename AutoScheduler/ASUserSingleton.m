//
//  ASUserSingleton.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "ASUserSingleton.h"

NSString* USER_DEFUALTS_REDMINE_HOME_URL = @"USER_DEFUALTS_REDMINE_HOME_URL";
NSString* USER_DEFUALTS_REDMINE_USER_NAME = @"USER_DEFUALTS_REDMINE_USER_NAME";
NSString* USER_DEFUALTS_REDMINE_PASSWORD = @"USER_DEFUALTS_REDMINE_PASSWORD";
NSString * USER_DEFUALTS_LOG_IN = @"USER_DEFUALTS_LOG_IN";


@implementation ASUserSingleton

static ASUserSingleton *sharedInstance = nil;

+(ASUserSingleton*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[ASUserSingleton alloc] init];
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"",USER_DEFUALTS_REDMINE_HOME_URL,
                             @"",USER_DEFUALTS_REDMINE_USER_NAME,
                             @"",USER_DEFUALTS_REDMINE_PASSWORD,
                             nil];
        [defaults registerDefaults:dic];
    }
    return sharedInstance;
}

-(NSString*)redmineURL
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults objectForKey:USER_DEFUALTS_REDMINE_HOME_URL];
}
-(void)setRedmineURL:(NSString *)redmineURL
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:redmineURL forKey:USER_DEFUALTS_REDMINE_HOME_URL];
    [userdefaults synchronize];
    
}

-(NSString*)userName
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults objectForKey:USER_DEFUALTS_REDMINE_USER_NAME];
}
-(void)setUserName:(NSString *)userName
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:userName forKey:USER_DEFUALTS_REDMINE_USER_NAME];
    [userdefaults synchronize];
    
}

-(NSString*)password
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    return [
            userdefaults objectForKey:USER_DEFUALTS_REDMINE_PASSWORD
            ];
}
-(void)setPassword:(NSString*)password
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:password forKey:USER_DEFUALTS_REDMINE_PASSWORD];
    [userdefaults synchronize];
}

-(BOOL)iSUserSignedIn
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults boolForKey:USER_DEFUALTS_LOG_IN];
}
-(void)setISUserSignedIn:(BOOL)SUserSignedIn
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setBool:SUserSignedIn forKey:USER_DEFUALTS_LOG_IN];
    [userdefaults synchronize];
    
}

@end

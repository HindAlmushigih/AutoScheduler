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
+(void)loginToASWithusername:(NSString*)username andPassword:(NSString*)password;

@end

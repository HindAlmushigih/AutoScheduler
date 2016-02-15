//
//  ASUserSingleton.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASUserSingleton : NSObject

@property NSString *userName;
@property NSString *password;
@property NSString *redmineURL;
@property BOOL iSUserSignedIn;
+(ASUserSingleton*)sharedInstance;

@end

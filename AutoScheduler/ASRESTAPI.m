//
//  ASRESTAPI.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "ASRESTAPI.h"

NSString* USER_DEFUALTS_REDMINE = @"USER_DEFUALTS_REDMINE_HOME_URL";
BOOL logging;

@implementation ASRESTAPI


static ASRESTAPI *sharedInstance = nil;

+(ASRESTAPI*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[ASRESTAPI alloc] init];
        sharedInstance.redmineServer = [NSURL URLWithString:[[ASUserSingleton sharedInstance]redmineURL]];
        sharedInstance.request = [[NSMutableURLRequest alloc] init];
        [sharedInstance.request setURL:sharedInstance.redmineServer];
    }

    return sharedInstance;
}

+ (BOOL)logging {
    return logging;
}
+ (void)setLogging:(BOOL)newValue {
    logging = newValue;
}



+(void)loginToASWithusername:(NSString*)username andPassword:(NSString*)password
{
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",username, password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu" , (unsigned long)[postData length]];

    [sharedInstance.request setHTTPMethod:@"POST"];
    [sharedInstance.request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [sharedInstance.request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [sharedInstance.request setValue:@"Basic YWRtaW46YWRtaW4=" forHTTPHeaderField:@"authorization"];
    [sharedInstance.request setHTTPBody:postData];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:sharedInstance.request
                                  
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (error) {
                                          // Handle error...
                                          NSLog(@"something wrong");
                                          return;
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      
                                      [self setLogging:true];
                                      
                                      NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      NSLog(@"Response Body:\n%@\n", body);
                                  }];
    [task resume];

}

+(void)currentUsername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(NSDictionary* response))completion
{

    NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];

    NSString *base64String = [authData base64EncodedStringWithOptions:0];

    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];
    
    __block NSDictionary *currentUserdictionarytest = nil;
    NSDictionary *headers = @{ @"authorization": authValue,
                               @"accept": @"application/json",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"0a47efb3-c559-c0f9-8276-87cbdbe76c9d" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://172.16.230.102/redmine23/users/current.json"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSError *JSONError = nil;
                                                        currentUserdictionarytest = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                options:0
                                                                                                                  error:&JSONError];
                                                       
//                                                        NSArray* curentuser = [currentUserdictionarytest objectForKey:@"user"];
//                                                        NSLog(@"printing the array here: %@", curentuser);
//                                                        NSNumber *number = currentUserdictionarytest[@"user"][@"id"];
//                                                        NSLog(@"printing the id here: %@", number);
//                                                        NSString *fn = currentUserdictionarytest[@"user"][@"firstname"];
//                                                        NSLog(@"printing the id here: %@", fn);
                                                        
                                                        if (JSONError)
                                                        {
                                                            NSLog(@"Serialization error: %@", JSONError.localizedDescription);
                                                        }
                                                        else
                                                        {
                                                            completion(currentUserdictionarytest);
                                                            NSLog(@"Response: %@", currentUserdictionarytest);
                                                        }
                                                    }
                                                
                                                }];
    [dataTask resume];
}

@end

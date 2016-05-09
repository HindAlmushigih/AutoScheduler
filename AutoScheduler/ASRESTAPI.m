//
//  ASRESTAPI.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "ASRESTAPI.h"
#import "ASUserSingleton.h"

NSString* USER_DEFUALTS_REDMINE = @"USER_DEFUALTS_REDMINE_HOME_URL";
BOOL logging;

@implementation ASRESTAPI


static ASRESTAPI *sharedInstance = nil;

+(ASRESTAPI*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[ASRESTAPI alloc] init];
    }
    return sharedInstance;
}


-(NSString*)redmineURL
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults objectForKey:USER_DEFUALTS_REDMINE];
}


-(void)setRedmineURL:(NSString *)redmineURL
{
    NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:redmineURL forKey:USER_DEFUALTS_REDMINE];
    [userdefaults synchronize];
}

+ (BOOL)logging {
    return logging;
}
+ (void)setLogging:(BOOL)newValue {
    logging = newValue;
}


+(void)loginToASWithusername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(BOOL response))completion
{
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",username, password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu" , (unsigned long)[postData length]];
    
    NSString *url = [[[ASRESTAPI sharedInstance]redmineURL] stringByAppendingString:@"login"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"Basic YWRtaW46YWRtaW4=" forHTTPHeaderField:@"authorization"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                  
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (error) {
                                          // Handle error...
                                          NSString *errorMsg;
                                          
                                          if ([[error domain] isEqualToString:NSURLErrorDomain]) {
                                              switch ([error code]) {
                                                  case NSURLErrorCannotFindHost:
                                                      errorMsg = NSLocalizedString(@"Cannot find specified host. Retype URL.", nil);
                                                      break;
                                                  case NSURLErrorCannotConnectToHost:
                                                      errorMsg = NSLocalizedString(@"Cannot connect to specified host. Server may be down.", nil);
                                                      break;
                                                  case NSURLErrorNotConnectedToInternet:
                                                      errorMsg = NSLocalizedString(@"Cannot connect to the internet. Service may not be available.", nil);
                                                      break;
                                                  default:
                                                      errorMsg = [error localizedDescription];
                                                      break;
                                              }
                                          } else {
                                              errorMsg = [error localizedDescription];
                                          }
                                          
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                      }
                                      
                                      [self setLogging:true];
                                      
                                      NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      NSLog(@"Response Body:\n%@\n", body);
                                      if ([body containsString:@"Invalid user or password"])
                                      {
                                          NSLog(@"Invalid user or password");
                                          
                                          completion(NO);
                                      }
                                      else
                                          completion(YES);
                                  }];
    [task resume];

}

//- (void)URLSession:(NSURLSession *)session
//didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
// completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
//                             NSURLCredential *credential))completionHandler
//{
//    NSLog(@"did receive challenge method called with task");
//    NSString* username = [[ASUserSingleton sharedInstance]userName];
//    NSString* password = [[ASUserSingleton sharedInstance]password];
//    if ([challenge previousFailureCount] == 0) {
//        NSURLCredential *newCredential;
//        newCredential = [NSURLCredential credentialWithUser:username
//                                                   password:password
//                                                persistence:NSURLCredentialPersistenceNone];
//        [[challenge sender] useCredential:newCredential
//               forAuthenticationChallenge:challenge];
//    } else {
//        [[challenge sender] cancelAuthenticationChallenge:challenge];
//    }
//
//}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    NSLog(@"did receive challenge method called with task");
    NSString* username = [[ASUserSingleton sharedInstance]userName];
    NSString* password = [[ASUserSingleton sharedInstance]password];
    if ([challenge previousFailureCount] == 0) {
        
        NSURLCredential *newCredential;
        newCredential = [NSURLCredential credentialWithUser:username
                                                   password:password
                                                persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
        
        
        
        
        //completionHandler()
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

+(void)currentUsername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(NSDictionary* response))completion
{

    NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];

    NSString *base64String = [authData base64EncodedStringWithOptions:0];

    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:username
                                                             password:password
                                                          persistence:NSURLCredentialPersistencePermanent];
//    http://demo.redmine.org/
//    http://demo.redmine.org/
    NSString *str=[[ASRESTAPI sharedInstance]redmineURL];
    str = [str stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc]
                                             initWithHost:
                                            str                                             port:80
                                             protocol:@"http"
                                             realm:@"Redmine API"
                                             authenticationMethod:NSURLAuthenticationMethodHTTPBasic];
    
    
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credential
                                                        forProtectionSpace:protectionSpace];
//    [protectionSpace release];
    
    __block NSDictionary *currentUserdictionarytest = nil;
    NSDictionary *headers = @{ @"authorization": authValue,
                               @"accept": @"application/json",
                               @"accept": @"text/html",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"0a47efb3-c559-c0f9-8276-87cbdbe76c9d",
                               @"www-authenticate": @"Basic realm=\"Redmine API\""};
   // WWW-Authenticate: Basic realm="Redmine API"
    
    NSString *url = [[[ASRESTAPI sharedInstance]redmineURL] stringByAppendingString:@"users/current.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfigObject.URLCredentialStorage = [NSURLCredentialStorage sharedCredentialStorage];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue:nil]; //[NSOperationQueue mainQueue]]; //[NSURLSession sharedSession];
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
                                                        NSLog(@"Printing current user data: %@", data);
                                                        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                         NSLog(@"Printing current user data string: %@", str);

                                                        
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

+(void)projectsListUsername:(NSString*)username andPassword:(NSString*)password completionBlock:(void(^)(NSDictionary* response, NSArray* projectArray))completion
{
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64String = [authData base64EncodedStringWithOptions:0];
    
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];
    
    __block NSDictionary *projectsDic = nil;
    NSDictionary *headers = @{ @"authorization": authValue,
                               @"accept": @"application/json"
                               };
    
    NSString *url = [[[ASRESTAPI sharedInstance]redmineURL] stringByAppendingString:@"projects.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
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
                                                        projectsDic = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                    options:0
                                                                                                                      error:&JSONError];
                                                        
                                                                                                               NSArray* projectsArr = [projectsDic objectForKey:@"projects"];
                                                        completion(projectsDic, projectsArr);
                                                        
                                                        if (JSONError)
                                                        {
                                                            NSLog(@"Serialization error: %@", JSONError.localizedDescription);
                                                        }
                                                        else
                                                        {
                                    
                                                            NSLog(@"Response: %@", projectsDic);
                                                        }
                                                    }
                                                    
                                                }];    [dataTask resume];
}


+(void)createProjectUsername:(NSString*)username andPassword:(NSString*)password andProject:(NSDictionary*)project
{
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64String = [authData base64EncodedStringWithOptions:0];
    
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];
    
    
    NSDictionary *headers = @{ @"authorization": authValue,
                               @"content-type": @"application/json",
                               @"content-type": @"http//172.16.230.102/redmine23/projects/new"
                               };
    
    NSString *url = [[[ASRESTAPI sharedInstance]redmineURL] stringByAppendingString:@"projects"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    
    /*
     Parameters:
     project (required): a hash of the project attributes, including:
     name (required): the project name
     identifier (required): the project identifier
     description
     {
     "project": {
     "name": "",
     "identifier": "example",
     "description": "",
     }
     }
     **/
    
    NSData *projectData = [NSJSONSerialization dataWithJSONObject:project options:NSJSONWritingPrettyPrinted error:nil];

    [request setHTTPBody:projectData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        // Handle error...
                                                        NSLog(@"something wrong");
                                                        return;
                                                    }
                                                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                        NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                                        NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                                    }
                                                    NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSLog(@"Response Body:\n%@\n", body);
                                                }];
    [dataTask resume];
}


+(void)issuesListUsername:(NSString*)username andPassword:(NSString*)password forProjectName:(NSString*)projectname completionBlock:(void(^)(NSDictionary* response, NSArray* issueArray))completion
{
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64String = [authData base64EncodedStringWithOptions:0];
    
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];
    
    __block NSDictionary *issuesDic = nil;
    NSDictionary *headers = @{ @"authorization": authValue,
                               @"accept": @"application/json"
                               };
    
    //http://172.16.231.19/redmine23/projects/auto-scheduler-ios-app/issues.json
    
    NSString *url = [[[ASRESTAPI sharedInstance]redmineURL] stringByAppendingString:@"projects/"];
    NSString *fullURL = [url stringByAppendingString:projectname];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullURL]
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
                                                        issuesDic = [NSJSONSerialization JSONObjectWithData:data
                                                                                                      options:0
                                                                                                        error:&JSONError];
                                                        
                                                        NSArray* issuesArr = [issuesDic objectForKey:@"issues"];
                                                        completion(issuesDic, issuesArr);
                                                 
                                                        
                                                        if (JSONError)
                                                        {
                                                            NSLog(@"Serialization error: %@", JSONError.localizedDescription);
                                                        }
                                                        else
                                                        {
                                                            
                                                            NSLog(@"Response: %@", issuesDic);
                                                        }
                                                    }
                                                    
                                                }];    [dataTask resume];
}

+(void)createIssueUsername:(NSString*)username andPassword:(NSString*)password forProjectName:(NSString*)projectname andIssue:(NSDictionary*)issue
{
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64String = [authData base64EncodedStringWithOptions:0];
    
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];

    
    NSDictionary *headers = @{ @"authorization": authValue,
                               @"content-type": @"application/json"
                               };
    
    
    
    NSString *url = [[[ASRESTAPI sharedInstance]redmineURL] stringByAppendingString:@"projects/"];
    NSString *fullURL = [url stringByAppendingString:projectname];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullURL]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];

    
    NSData *issueData = [NSJSONSerialization dataWithJSONObject:issue options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"Printing JSON Data%@", issueData);
    [request setHTTPBody:issueData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        // Handle error...
                                                        NSLog(@"something wrong");
                                                        return;
                                                    }
                                                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                        NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                                        NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                                    }
                                                    NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSLog(@"Response Body:\n%@\n", body);
                                                }];
    [dataTask resume];
}

@end

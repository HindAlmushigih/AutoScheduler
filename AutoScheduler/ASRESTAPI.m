//
//  ASRESTAPI.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "ASRESTAPI.h"

NSString* USER_DEFUALTS_REDMINE = @"USER_DEFUALTS_REDMINE_HOME_URL";

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

+(void)loginToASWithusername:(NSString*)username andPassword:(NSString*)password
{
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",username, password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu" , (unsigned long)[postData length]];
 //   NSURL *url = [NSURL URLWithString:@"http://172.16.231.19/redmine23/login"];
   // NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  //  [request setURL:url];
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
                                          return;
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      
                                      NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      NSLog(@"Response Body:\n%@\n", body);
                                  }];
    [task resume];
//    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:webView];
//    [webView loadRequest:request];

}

@end

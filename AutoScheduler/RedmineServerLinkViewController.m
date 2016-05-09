//
//  RedmineServerLinkViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 22/4/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "RedmineServerLinkViewController.h"
#import "ASRESTAPI.h"
#import "swrevealViewController.h"
#import "LoadingView.h"

@interface RedmineServerLinkViewController ()
@property (weak, nonatomic) IBOutlet UITextField *serverlinkField;

@end


@implementation RedmineServerLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)next:(id)sender {
    [self addLoadingViewToView];
    __block NSString* errorMessage = @"";
    if ([self.serverlinkField.text length] == 0) {
        [self removeLoadingViewFromView];
        errorMessage = @"Check the empty field";
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
    else {
        
        [self setUpServerLink:self.serverlinkField.text completionBlock:^(BOOL response, NSString *Msg) {
            if(response)
            {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self removeLoadingViewFromView];
                     [[ASRESTAPI sharedInstance]setRedmineURL:self.serverlinkField.text];
                UINavigationController *navigation = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
                     [self.revealViewController setFrontViewController:navigation];
                 });
            }
            else
            {
//                http://172.16.231.19/redmine23
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self removeLoadingViewFromView];
                    errorMessage = Msg;
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                               message:errorMessage
                                                                        preferredStyle:UIAlertControllerStyleActionSheet];
                    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                          NSLog(@"You pressed OK");
                                                                      }];
                    [alert addAction:firstAction];
                    [self presentViewController:alert animated:YES completion:nil];
                });
            }
        }];
        
    }
}


-(void)setUpServerLink:(NSString*)url completionBlock:(void(^)(BOOL response, NSString* Msg))completion
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (error) {
                                          NSLog(@"Ther's an error");
                                          
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
                                          
                                          completion(NO,errorMsg);
                                          
                                          // Handle error...
                                      }
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSString* Msg;
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          Msg = @"OK";
                                          completion(YES,Msg);
                                      }
                                      
                                  }];
    [task resume];
}

-(LoadingView*)creatLoadingView
{
    self.loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    return self.loadingView;
}
-(void)addLoadingViewToView
{
    self.loadingView = [self creatLoadingView];
    [self.loadingView addView];
    [self.view addSubview:self.loadingView];
}
-(void)removeLoadingViewFromView
{
    [self.loadingView removeView];
    [self.loadingView removeFromSuperview];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    UINavigationController *navigation = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
//    [self.revealViewController setFrontViewController:navigation];
//    
//}


@end

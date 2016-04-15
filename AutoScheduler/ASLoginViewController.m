//
//  ASLoginViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "ASLoginViewController.h"
#import "HomeViewController.h"
#import"SWRevealViewController.h"
@interface ASLoginViewController ()

@end

NSString* UserSignedInNotification = @"UserSignedInNotification";

@implementation ASLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ASLogin:(id)sender {
   __block NSString* errorMessage = @"";
    __block BOOL userOrPass;
    if ([self.ASUsernameField.text length] == 0 || [self.ASPasswordField.text length] == 0) {
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
        
        [self setupLoadingIndicator];
        [[ASUserSingleton sharedInstance]setUserName:self.ASUsernameField.text];
        [[ASUserSingleton sharedInstance]setPassword:self.ASPasswordField.text];
        [[ASUserSingleton sharedInstance]setRedmineURL:@"http://172.16.231.19/redmine23/login"];
        [ASRESTAPI sharedInstance];
        [ASRESTAPI loginToASWithusername:self.ASUsernameField.text andPassword:self.ASPasswordField.text completionBlock:^(BOOL response) {
            
            userOrPass = response;
            if (userOrPass == YES) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [[ASUserSingleton sharedInstance]setISUserSignedIn:YES];
                                [[NSNotificationCenter defaultCenter] postNotificationName:UserSignedInNotification object:nil];
                                [self showHomeScreen];
                            });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                errorMessage = @"Invalid user or password";
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


-(void)showHomeScreen
{
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
    UINavigationController *navigation = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
    
    [self.revealViewController setFrontViewController:navigation];
    [self.revealViewController setFrontViewPosition:FrontViewPositionLeft];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)setupLoadingIndicator
{
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(65, 40, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"Loading...";
    [loadingView addSubview:loadingLabel];
    [self.view addSubview:loadingView];
    [activityView startAnimating];
}



@end

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
    [self addLoadingViewToView];
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
        [self removeLoadingViewFromView];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        [[ASUserSingleton sharedInstance]setUserName:self.ASUsernameField.text];
        [[ASUserSingleton sharedInstance]setPassword:self.ASPasswordField.text];
        [ASRESTAPI sharedInstance];
        [ASRESTAPI loginToASWithusername:self.ASUsernameField.text andPassword:self.ASPasswordField.text completionBlock:^(BOOL response) {
            
            userOrPass = response;
            if (userOrPass == YES) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [[ASUserSingleton sharedInstance]setISUserSignedIn:YES];
                                [[NSNotificationCenter defaultCenter] postNotificationName:UserSignedInNotification object:nil];
                                [self removeLoadingViewFromView];
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
                [self removeLoadingViewFromView];
                
            }
            
        }];
        

    }
}


-(void)showHomeScreen
{
    [self removeLoadingViewFromView];
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


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator {
    
    NSLog(@"I have been called");
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    //The device has already rotated, that's why this method is being called.
    
    // before rotation
    
    [coordinator animateAlongsideTransition:^(id  _Nonnull context) {
        // during rotation: update our view's bounds and centre
        NSLog(@"the view will be changed");
        
    } completion:^(id  _Nonnull context) {
        
        // after rotation
        
    }];
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

@end

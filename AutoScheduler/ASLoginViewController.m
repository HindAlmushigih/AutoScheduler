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
    
    
    NSString* errorMessage = @"";
    
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
        [[ASUserSingleton sharedInstance]setUserName:self.ASUsernameField.text];
        [[ASUserSingleton sharedInstance]setPassword:self.ASPasswordField.text];
        [[ASUserSingleton sharedInstance]setRedmineURL:@"http://172.16.231.19/redmine23/"];
        [ASRESTAPI sharedInstance];
        [ASRESTAPI loginToASWithusername:self.ASUsernameField.text andPassword:self.ASPasswordField.text];
        [self prepareForSegue:@"GoToHome" sender:sender];
        //[self performSegueWithIdentifier:@"MySegue" sender:sender];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if ([[segue identifier] isEqualToString:@"GoToHome"])
//    {
//        
//       // SidebarViewController *sbvc = [[SidebarViewController alloc] init];
//        HomeViewController *home = [[HomeViewController alloc] init];
//        UINavigationController *menuVC = [[UINavigationController alloc] initWithRootViewController:home];
//        
//        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:menuVC frontViewController:menuVC];
//
//        
//        // Get reference to the destination view controller
//        HomeViewController *vc = [segue destinationViewController];
    [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.


@end

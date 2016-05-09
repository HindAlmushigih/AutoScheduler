//
//  HomeViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "ASUserSingleton.h"
#import "ASLoginViewController.h"
#import "ASRESTAPI.h"
#import "ASUserSingleton.h"

@interface HomeViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *signOutButton;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (weak, nonatomic) IBOutlet UILabel *userLastLoginOn;
@end

/**
 user =     {
 "api_key" = //;
 "created_on" = "2016-02-02T01:02:04Z";
 firstname = Redmine;
 id = 1;
 "last_login_on" = "2016-02-19T15:17:24Z";
 lastname = Admin;
 login = admin;
 mail = "autoschedulerapp@gmail.com";
 };
 }
 **/


NSString * USER_DEFUALTS_LOG_OUT = @"USER_DEFUALTS_LOG_OUT";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self customSetup];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];

    _revealButtonItem = [[UIBarButtonItem alloc]
                                         initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style: UIBarButtonItemStylePlain  target:revealController action:@selector(revealToggle:)];
    [self addLoadingViewToView];
    [self getThecurrentUser];
}
- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 1- So create a download method that takes a completion block,
// 2- and call the completion block inside the URL task's completion block.
// 3- Then call the download method and pass in a completion block that updates your label.
// 4- must use dispatch_async(dispatch_get_main_queue() to call the method thats update the UI elements

-(void)getThecurrentUser
{
    NSString* username = [[ASUserSingleton sharedInstance]userName];
    NSString* password = [[ASUserSingleton sharedInstance]password];
    _curentUser = nil;

    [ASRESTAPI currentUsername:username andPassword:password completionBlock:^(NSDictionary *response) {
        _curentUser = response;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeLoadingViewFromView];
            [self setupUserLabel];
        });
    }];
}

 -(void)setupUserLabel
{
    NSString *fn = _curentUser[@"user"][@"firstname"];
    NSString *ln = _curentUser[@"user"][@"lastname"];
    [self.UserName setText:[NSString stringWithFormat:@"Welcom: %@ %@",fn,ln]];
    
    NSString *mail = _curentUser[@"user"][@"mail"];
    [self.userEmail setText:[NSString stringWithFormat:@"Email: %@",mail]];
    
    
    NSString *last_login_on = _curentUser[@"user"][@"last_login_on"];
    [self.userLastLoginOn setText:[NSString stringWithFormat:@"Last connection: %@",last_login_on]];
}

- (IBAction)ASSignOut:(id)sender {
    
    [[ASUserSingleton sharedInstance]setISUserSignedIn:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_DEFUALTS_LOG_OUT object:nil];
//    
//    
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *loginViewController = [mainStoryboard instantiateInitialViewController];
//    loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    
//    // [self dismissViewControllerAnimated:NO completion:nil];
//    [[self presentedViewController] dismissViewControllerAnimated:NO completion:nil];
//    
//    [self presentViewController:loginViewController animated:NO completion:nil];
//    
//    [self.navigationController dismissViewControllerAnimated:YES
//                                                  completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

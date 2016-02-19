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
 "api_key" = 705a4e355244cebc57bace2cf8ab9449ff8df947;
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
   // UIBarButtonItem *
    _revealButtonItem = [[UIBarButtonItem alloc]
                                         initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style: UIBarButtonItemStylePlain  target:revealController action:@selector(revealToggle:)];
                                         //initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    //self.navigationItem.leftBarButtonItem = revealButtonItem;
    [self getThecurrentUser];
    [self setupUserLabel];
    
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

-(void)getThecurrentUser
{
    NSString* username = [[ASUserSingleton sharedInstance]userName];
    NSString* password = [[ASUserSingleton sharedInstance]password];
    _curentUser = nil;
    [ASRESTAPI currentUsername:username andPassword:password];
    
    _curentUser = [ASRESTAPI currentuserDictionary];
}

-(void)setupUserLabel
{
    NSString *fn = _curentUser[@"user"][@"firstname"];
    NSString *ln = _curentUser[@"user"][@"lastname"];
//   // NSString* fullName = [NSString stringWithFormat:@"Welcom: %@ %@",fn,ln];
    [self.UserName setText:[NSString stringWithFormat:@"Welcom: %@ %@",fn,ln]];
     //@"Welcom: ",fn,ln];
   NSString *mail = _curentUser[@"user"][@"mail"];
    
    [self.userEmail setText:[NSString stringWithFormat:@"Email: %@",mail]];
     NSString *last_login_on = _curentUser[@"user"][@"last_login_on"];
    
    [self.userLastLoginOn setText:[NSString stringWithFormat:@"Last connection: %@",last_login_on]];
}

- (IBAction)ASSignOut:(id)sender {
    
    [[ASUserSingleton sharedInstance]setISUserSignedIn:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_DEFUALTS_LOG_OUT object:nil];
    
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *loginViewController = [loginStoryboard instantiateInitialViewController];
    loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
     [self dismissViewControllerAnimated:NO completion:nil];
    [[self presentedViewController] dismissViewControllerAnimated:NO completion:nil];
    
    [self presentViewController:loginViewController animated:NO completion:nil];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    ASLoginViewController *initView = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
//    [initView setModalPresentationStyle:UIModalPresentationFullScreen];
//    [self presentViewController:initView animated:NO completion:nil];

//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//        UIViewController *initView = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
//        [initView setModalPresentationStyle:UIModalPresentationFullScreen];
//        [self presentViewController:initView animated:NO completion:nil];
    
//    UIViewController *vcNew = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"Login"];
    
    // Swap out the Front view controller and display
//    [self.revealViewController setFrontViewController:initView.navigationController];
//    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];


//    UINavigationController *navigation = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
//    
//    [self.revealViewController setFrontViewController:navigation];
//    [self.revealViewController setFrontViewPosition:FrontViewPositionLeft];

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

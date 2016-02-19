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
@interface HomeViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *signOutButton;
@end

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

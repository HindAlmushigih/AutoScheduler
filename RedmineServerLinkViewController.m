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
    __block NSString* errorMessage = @"";
    if ([self.serverlinkField.text length] == 0) {
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
        [[ASRESTAPI sharedInstance]setRedmineURL:self.serverlinkField.text];
    }
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navigation = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    
    [self.revealViewController setFrontViewController:navigation];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

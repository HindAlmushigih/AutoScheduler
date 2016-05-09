//
//  NewProjectViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 22/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//


/**
 @Parameters:
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

#import "NewProjectViewController.h"
#import "ASRESTAPI.h"
#import "ASUserSingleton.h"

@interface NewProjectViewController ()
@property (weak, nonatomic) IBOutlet UITextField *projectName;
@property (weak, nonatomic) IBOutlet UITextView *projectDescription;
@property (weak, nonatomic) IBOutlet UITextField *projectIdentifier;

@end

@implementation NewProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.project = [[NSMutableDictionary alloc]init];
    self.projectDetails = [[NSMutableDictionary alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender{

    NSString* errorMessage = @"";
    
    if ([self.projectName.text length] == 0 || [self.projectDescription.text length] == 0 || [self.projectIdentifier.text length] == 0) {
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
        [self setAllProjectDicObj];
        NSString* username = [[ASUserSingleton sharedInstance]userName];
        NSString* password = [[ASUserSingleton sharedInstance]password];
        [ASRESTAPI createProjectUsername:username andPassword:password andProject:self.project];
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController dismissViewControllerAnimated:NO
                                               completion:nil];
    }
    
}
- (IBAction)cancel:(id)sender {
    [self.navigationController dismissViewControllerAnimated:NO
                                                  completion:nil];
}


-(void)setAllProjectDicObj
{
    
    self.projectDetails[@"name"] = self.projectName.text;
    self.projectDetails[@"identifier"] = self.projectIdentifier.text;
    self.projectDetails[@"description"] = self.projectDescription.text;
    self.project[@"project"] = self.projectDetails;
    
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

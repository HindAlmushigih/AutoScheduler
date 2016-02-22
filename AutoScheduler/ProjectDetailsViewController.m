//
//  ProjectDetailsViewController.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 22/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "ProjectDetailsViewController.h"

/*
 {"project":{"id":1,"name":"test","identifier":"test","description":"","homepage":"","created_on":"2016-02-17T23:07:02Z","updated_on":"2016-02-17T23:07:02Z"}}
 */


@interface ProjectDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nametextLabel;
@property (weak, nonatomic) IBOutlet UILabel *identifiertextLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdontextLabel;
@property (weak, nonatomic) IBOutlet UILabel *updated_ontextLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptiontextLabel;
@end

@implementation ProjectDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUptTheLabels];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUptTheLabels
{
    _nametextLabel.text = [_project objectForKey:@"name"];
    _identifiertextLabel.text = [_project objectForKey:@"identifier"];
    _createdontextLabel.text = [_project objectForKey:@"created_on"];
    _updated_ontextLabel.text = [_project objectForKey:@"updated_on"];
    _descriptiontextLabel.text = [_project objectForKey:@"description"];
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

//
//  ProjectDetailsViewController.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 22/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ProjectDetailsViewController;
//@protocol ProjectDetailsViewControllerDelegate <NSObject>
//- (void)projectDetailsViewControllerDidCancel:(ProjectDetailsViewController *)controller;
//- (void)projectDetailsViewControlleridSave:(ProjectDetailsViewController *)controller;
//@end


@interface ProjectDetailsViewController : UIViewController

@property NSDictionary* project;
//@property (nonatomic, weak) id <ProjectDetailsViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
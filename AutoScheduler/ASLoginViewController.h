//
//  ASLoginViewController.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASUserSingleton.h"
#import "ASRESTAPI.h"
#import "LoadingView.h"
@interface ASLoginViewController : UIViewController

@property (nonatomic, retain) LoadingView *loadingView;

@property (weak, nonatomic) IBOutlet UITextField *ASUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *ASPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *ASLogin;

@end

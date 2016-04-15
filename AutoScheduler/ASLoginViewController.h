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
@interface ASLoginViewController : UIViewController
{
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    UILabel *loadingLabel;
}

@property (nonatomic, retain) UIActivityIndicatorView * activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;

@property (weak, nonatomic) IBOutlet UITextField *ASUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *ASPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *ASLogin;

@end

//
//  HomeViewController.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 11/2/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"

@interface HomeViewController : UIViewController

@property (nonatomic, retain) LoadingView *loadingView;

@property NSDictionary* curentUser;
@end

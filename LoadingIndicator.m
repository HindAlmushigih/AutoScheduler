//
//  LoadingIndicator.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 14/4/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "LoadingIndicator.h"

@implementation LoadingIndicator

-(void)setupLoadingIndicator:(UIView*)view
{
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(65, 40, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"Loading...";
    [loadingView addSubview:loadingLabel];
    [view addSubview:loadingView];
}

-(void)startAnimatingLoadingIndicator:(BOOL)start forAview:(UIView*)view
{
    if (start)
    {
        
//        view.subviews
        [activityView startAnimating];
    }
    else
    {
        [activityView stopAnimating];
    }
}

-(void)removeLoadingIndicator:(UIView*)view
{
    [loadingView removeFromSuperview];
}

@end

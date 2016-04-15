//
//  LoadingIndicator.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 14/4/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LoadingIndicator : NSObject
{
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    UILabel *loadingLabel;
}

@property (nonatomic, retain) UIActivityIndicatorView * activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;


@end

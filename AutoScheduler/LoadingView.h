//
//  LoadingView.h
//  AutoScheduler
//
//  Created by Hind Almushigih on 25/4/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (nonatomic, retain) UIActivityIndicatorView * activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;

-(void)addView;
-(void)removeView;

@end

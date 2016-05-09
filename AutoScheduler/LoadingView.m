//
//  LoadingView.m
//  AutoScheduler
//
//  Created by Hind Almushigih on 25/4/16.
//  Copyright © 2016 Gannon University. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _loadingView = [[UIView alloc] initWithFrame:self.bounds];
        _loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _loadingView.clipsToBounds = YES;
        _loadingView.layer.cornerRadius = 10.0;
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.frame = CGRectMake(65, 40, _activityView.bounds.size.width, _activityView.bounds.size.height);
        [_loadingView addSubview:_activityView];
        
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
        _loadingLabel.backgroundColor = [UIColor clearColor];
        _loadingLabel.textColor = [UIColor whiteColor];
        _loadingLabel.adjustsFontSizeToFitWidth = YES;
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.text = @"Loading...";
        [_loadingView addSubview:_loadingLabel];
    }
    return self;
}


-(void)addView
{
    [self addSubview:_loadingView];
    [_activityView startAnimating];
}


-(void)removeView
{
    [_activityView stopAnimating];
    [_loadingView removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

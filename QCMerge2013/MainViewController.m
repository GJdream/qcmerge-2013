//
//  MainViewController.m
//  QCMerge2013
//
//  Created by Chris Moore on 4/11/13.
//  Copyright (c) 2013 Gaslight. All rights reserved.
//

#import "MainViewController.h"
#import "WebViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    for (UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel*)view;
            label.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:45];
            label.userInteractionEnabled = YES;

            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showWebView:)];
            [label addGestureRecognizer:tap];
        }
    }

    [self animateLogo];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animateLogo
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect mainRect = self.view.frame;
        CGPoint center = CGPointMake(CGRectGetMidX(mainRect), CGRectGetMidY(mainRect));
        self.logoImage.center = center;
    }];
}

- (void)showWebView:(UIGestureRecognizer *)gestureRecognizer
{
    UILabel *label = (UILabel *)gestureRecognizer.view;
    [self performSegueWithIdentifier:@"showWebView" sender:label];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showWebView"])
    {
        NSString *title = [sender text];
        [segue.destinationViewController setTitle:[title capitalizedString]];
    }
}
@end

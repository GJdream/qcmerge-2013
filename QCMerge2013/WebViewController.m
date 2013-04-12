//
//  WebViewController.m
//  QCMerge2013
//
//  Created by Chris Moore on 4/11/13.
//  Copyright (c) 2013 Gaslight. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property BOOL webViewLoaded;
@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.webViewLoaded)
    {
        NSString *url = @"http://qcmerge.com#";
        NSString *area = self.title;
        [[url stringByAppendingString:area] lowercaseString];

        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        self.webViewLoaded = YES;
        NSLog(@"loaded");
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

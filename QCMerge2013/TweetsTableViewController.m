//
//  TweetsTableViewController.m
//  QCMerge2013
//
//  Created by Chris Moore on 4/12/13.
//  Copyright (c) 2013 Gaslight. All rights reserved.
//

#import "TweetsTableViewController.h"
#import "Tweet.h"

@interface TweetsTableViewController ()

@end

@implementation TweetsTableViewController
@synthesize tweets;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tweets = [NSMutableArray array];
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self populateTweetsWithSearch:@"QCMerge"];
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

-(void) populateTweetsWithSearch:(NSString *)searchString
{
    [self.tweets removeAllObjects];

    NSString *url = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@", searchString];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
        id results = [json valueForKey:@"results"];

        [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Tweet *tweet = [[Tweet alloc] init];
            tweet.text = [obj valueForKey:@"text"];
            tweet.profileImageUrl = [obj valueForKey:@"profile_image_url"];

            [self.tweets addObject:tweet];
        }];

        [self.tableView reloadData];
        [self.tableView setNeedsDisplay];
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Error retrieving Tweets"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Ok", nil];
        [alert show];
    }];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        [[cell textLabel] setTextColor:[UIColor whiteColor]];
        [[cell textLabel] setNumberOfLines:0];
        [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
        [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:10]];

    }

    Tweet *tweet = [self.tweets objectAtIndex:[indexPath row]];
    cell.textLabel.text = tweet.text;
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tweet.profileImageUrl]]];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

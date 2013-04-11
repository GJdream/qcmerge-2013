//
//  MainViewController.h
//  QCMerge2013
//
//  Created by Chris Moore on 4/11/13.
//  Copyright (c) 2013 Gaslight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakerLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *sponsorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@end

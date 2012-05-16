//
//  TweetViewController.h
//  Twitterly
//
//  Created by Armin Kroll on 16/05/12.
//  Copyright (c) 2012 jTribe Holdings Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetViewController : UIViewController

@property (weak) IBOutlet UILabel *tweetTextLabel;
@property (strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (id) initWithTweet:(Tweet*)tweet;

@end

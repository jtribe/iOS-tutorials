//
//  TweetViewController.m
//  Twitterly
//
//  Created by Armin Kroll on 16/05/12.
//  Copyright (c) 2012 jTribe Holdings Pty Ltd. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

@synthesize tweetTextLabel;
@synthesize tweet = tweet_;
@synthesize imageView;

- (id) initWithTweet:(Tweet*)tweet
{
    self = [super init];
    if (self) {
        self.tweet = tweet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tweetTextLabel.text = self.tweet.text;
    self.title = @"Tweet Details";
    self.imageView.alpha = 0.0;
    NSLog(@"loading img...");
    [self.tweet loadImageWithSuccessHandler:^(id loadedImage) {
        NSLog(@"img loaded");
        [UIView animateWithDuration:1.0 animations:^{
            // use the newly loaded image
            self.imageView.image = loadedImage;
            // scale image view 
            self.imageView.transform = CGAffineTransformMakeScale(4.0, 4.0);
            self.imageView.alpha = 1.0;
            self.imageView.center = CGPointMake(self.imageView.center.x, 
                                                     self.imageView.center.y-260);
            self.tweetTextLabel.center = CGPointMake(self.tweetTextLabel.center.x, 
                                                  self.tweetTextLabel.center.y+140);
        }];
    }];
    

}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

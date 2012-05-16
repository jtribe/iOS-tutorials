//
//  TweetsViewController.h
//  Twitterly
//
//  Created by Armin Kroll on 16/05/12.
//  Copyright (c) 2012 jTribe Holdings Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetsViewController : UITableViewController

@property (strong) NSArray* tweets;

- (id) initWithTweets:(NSArray*)tweets;

@end

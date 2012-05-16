//
//  AppDelegate.h
//  Twitterly
//
//  Created by Armin Kroll on 16/05/12.
//  Copyright (c) 2012 jTribe Holdings Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TweetsViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TweetsViewController *viewController;

@end

//
//  Tweet.m
//  Twitterly
//
//  Created by Armin Kroll on 16/05/12.
//  Copyright (c) 2012 jTribe Holdings Pty Ltd. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet
@synthesize text = text_;
@synthesize imageURL = imageURL_;
@synthesize image = image_;

- (void) loadImageWithSuccessHandler:(void(^)(id param))success 
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:3];
    [queue addOperationWithBlock:^ {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURL]]];
        
        // Use GCD to run block on main thread
        dispatch_queue_t queue =  dispatch_get_main_queue();        
        dispatch_sync(queue, ^{ 
            success(image);
//            self.image = image;
        });
    }];
}


- (id) initWithText:(NSString*)text imageURL:(NSString*)imageURL
{
    self = [super init];
    if (self) {
        self.text = text;
        self.imageURL = imageURL;
    }
    return self;
}

@end

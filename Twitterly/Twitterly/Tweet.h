//
//  Tweet.h
//  Twitterly
//
//  Created by Armin Kroll on 16/05/12.
//  Copyright (c) 2012 jTribe Holdings Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (strong) NSString *text;
@property (strong) NSString *imageURL;
@property (strong) UIImage  *image;


- (id) initWithText:(NSString*)text imageURL:(NSString*)imageURL;
- (void) loadImageWithSuccessHandler:(void(^)(id param))success;

@end

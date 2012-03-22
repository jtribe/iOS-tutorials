//
//  ViewController.m
//  PinchZoomImage
//
//  Created by Armin Kroll on 22/02/12.
//  Copyright (c) 2012 jTribe Holdings Pty Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property CGSize orgSize;
@end


@implementation ViewController
@synthesize imageView;
@synthesize orgSize = orgSize_;

- (void) tapRecognizedGesture:(UIGestureRecognizer*)gesture
{
  NSLog(@"tapRecognizedGesture");
}

- (void) pinchRecognizedGesture:(UIPinchGestureRecognizer*)gesture
{
  if (gesture.state == UIGestureRecognizerStateEnded) {
    self.orgSize = self.imageView.frame.size;
    return;
  }

  NSLog(@"pinchRecognizedGesture Scale:%f, Velcity:%f", gesture.scale, gesture.velocity);
  CGPoint orgCentre = self.imageView.center;
  self.imageView.frame = CGRectMake(0,0, 
                                    self.orgSize.width * gesture.scale, 
                                    self.orgSize.height * gesture.scale);
  self.imageView.center = orgCentre;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(tapRecognizedGesture:)];
  tapRecognizer.numberOfTapsRequired = 2;
  [self.view addGestureRecognizer:tapRecognizer];
  
  // image zoom
  self.orgSize = self.imageView.frame.size;
  UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(pinchRecognizedGesture:)];
  [self.imageView addGestureRecognizer:pinchRecognizer];
  // selector demo
  [self performSelector:@selector(sampleSelector:) withObject:[NSString stringWithString:@"Bob"]];
  
}

- (void) sampleSelector:(id)object
{
  NSLog(@"sampleSlector");
}


@end

//
//  TweetsViewController.m
//  Twitterly
//
//  Created by Armin Kroll on 16/05/12.
//  Copyright (c) 2012 jTribe Holdings Pty Ltd. All rights reserved.
//

#import "TweetsViewController.h"
#import "Tweet.h"
#import "TweetViewController.h"
#import "JSONFramework.h"

@interface TweetsViewController ()

@end

@implementation TweetsViewController
@synthesize tweets = tweets_;

- (id) initWithTweets:(NSArray*)tweets
{
    self = [super init];
    if (self) {
        self.tweets = tweets;
    }
    return self;
}


- (void) loadTweets 
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:3];
    [queue addOperationWithBlock:^ {
        // request from twitter
        NSString *urlString = @"http://search.twitter.com/search.json?q=steve+jobs";
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:30.0];
        
        NSLog(@"Requesting tweets ... from %@", urlString);
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request 
                                                     returningResponse:nil 
                                                                 error:nil];
        
        NSString *stringReply = [[NSString alloc] initWithData:responseData 
                                                      encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", stringReply);
        // deserialise the data
        NSDictionary *jsonDictionary = [stringReply JSONValue];
        NSArray *results = [jsonDictionary objectForKey:@"results"];
        
        NSString *countString = [NSString stringWithFormat:@"tweets %d",[results count]];
        NSLog(@"%@ results", countString);

        //------
        // Create model
        NSMutableArray *tempTweets = [[NSMutableArray alloc] init];
        
        for(NSDictionary *tweetDict in results){
            NSString *tweetText = [tweetDict objectForKey:@"text"];  
            NSString *tweetImageURL = [tweetDict objectForKey:@"profile_image_url"];    
            
            Tweet *tweet = [[Tweet alloc] initWithText:tweetText imageURL:tweetImageURL];
            [tempTweets addObject:tweet];
        }
        NSLog(@"Parsing done.");
        
        // Use GCD to run block on main thread
        dispatch_queue_t queue =  dispatch_get_main_queue();        
        dispatch_sync(queue, ^{  
            self.tweets = tempTweets;
            [self.tableView reloadData];  
        });
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Tweets";
    
    [self loadTweets];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Tweet *tweet = [self.tweets objectAtIndex:indexPath.row];
    cell.textLabel.text = tweet.text;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    Tweet *tweet = [self.tweets objectAtIndex:indexPath.row];

    TweetViewController *detailViewController = [[TweetViewController alloc] initWithTweet:tweet];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     
}




/*
 //------
 // Parse the JSON
 NSDictionary *jsonDictionary = [stringReply JSONValue];
 NSArray *results = [jsonDictionary objectForKey:@"results"];
 
 NSString *countString = [NSString stringWithFormat:@"tweets %d",[results count]];
 NSLog(@"%@ results", countString);
 
 NSMutableArray *tempTweets = [[NSMutableArray alloc] init];
 
 for(NSDictionary *tweetDict in results){
 NSString *tweetText = [tweetDict objectForKey:@"text"];  
 //      NSString *imageURL = [tweetDict objectForKey:@"profile_image_url"];  
 
 Tweet *tweet = [[Tweet alloc] initWithText:tweetText];
 [tempTweets addObject:tweet];
 }
 NSLog(@"Parsing done.");
 
 // Use GCD to run block on main thread
 dispatch_queue_t queue =  dispatch_get_main_queue();        
 dispatch_sync(queue, ^{  
 self.tweets = tempTweets;
 [self.tableView reloadData];  
 });

 */
@end

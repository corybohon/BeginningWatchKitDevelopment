//
//  MasterViewController.m
//  Top10
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "JSONItem.h"
#import "NetworkController.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *objects;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Top 10 Tunes";
    [self reloadContent: self];
}

#pragma mark - Segues 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JSONItem *detailItem = [self.objects objectAtIndex:indexPath.row];
        
        DetailViewController *detailController = (DetailViewController *)[[[segue destinationViewController] viewControllers] firstObject];
        
        [detailController setDetailItem:detailItem];
    }
}

#pragma mark - Actions 
- (void)reloadContent:(id)sender
{
    [[NetworkController sharedNetworkController] retrieveJSONFeedWithCompletionHandler:^(NSError *error, NSArray *objects) {
        if (!error && objects) {
            self.objects = objects;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    } forNumberOfItems:10];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSONItem *item = [self.objects objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %@", (long)indexPath.row + 1, item.songTitle];
    
    return cell;
}

@end

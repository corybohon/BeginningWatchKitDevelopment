//
//  InterfaceController.m
//  Top10 WatchKit App Extension
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "InterfaceController.h"
#import "NetworkController.h"
#import "JSONItem.h"
#import "MainRow.h"

@interface InterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceTable *table;
@property (nonatomic, strong) NSArray *jsonItems;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    [self reloadData];
}

- (void)reloadData
{
    [[NetworkController sharedNetworkController] retrieveJSONFeedWithCompletionHandler:^(NSError *error, NSArray *objects) {
        
        [self.table setNumberOfRows:objects.count withRowType:@"MainRow"];
        
        for (NSUInteger row = 0; row < self.table.numberOfRows; row++) {
            MainRow *currentRow = [self.table rowControllerAtIndex:row];
            [currentRow configureWithJSONItem:[objects objectAtIndex:row] atIndex:row];
        }
        
        self.jsonItems = objects;
        
    } forNumberOfItems:10];
}

- (IBAction)reloadMenuButtonTapped:(id)sender
{
    [self reloadData];
}

@end


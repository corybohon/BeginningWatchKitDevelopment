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
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *backgroundColorGroup;
@property (nonatomic, strong) NSArray *jsonItems;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    [self reloadData];
    
    [self animateWithDuration:2.0f animations:^{
        [self.backgroundColorGroup setBackgroundColor:[UIColor blackColor]];
    }];
}

#pragma mark - Table Methods
- (void)reloadData
{
    [[NetworkController sharedNetworkController] retrieveJSONFeedWithCompletionHandler:^(NSError *error, NSArray *objects) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table insertRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)] withRowType:@"MainRow"];
            
            for (NSUInteger index = 0; index < self.table.numberOfRows; index ++) {
                MainRow *row = [self.table rowControllerAtIndex:index];
                
                [row configureWithJSONItem:[objects objectAtIndex:index] atIndex:index];
                
                [row.image setHidden:NO];
                [row.label setHidden:NO];
            }
        });
        
        self.jsonItems = objects;
        
    } forNumberOfItems:10];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeClick];
    JSONItem *jsonItem = [self.jsonItems objectAtIndex:rowIndex];
    [self pushControllerWithName:@"detailController" context:jsonItem];
}

#pragma mark - Actions
- (IBAction)reloadMenuButtonTapped:(id)sender
{
    [self reloadData];
}

@end


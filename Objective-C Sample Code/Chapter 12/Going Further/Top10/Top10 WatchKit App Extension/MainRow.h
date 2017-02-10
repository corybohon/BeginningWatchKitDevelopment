//
//  MainRow.h
//  Top10
//
//  Created by Cory Bohon on 12/11/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
#import "JSONItem.h"

@interface MainRow : NSObject

@property (nonatomic, weak) IBOutlet WKInterfaceImage *image;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *label;

- (void)configureWithJSONItem:(JSONItem *)item atIndex:(NSUInteger)index;

@end

//
//  MainRow.m
//  Top10
//
//  Created by Cory Bohon on 12/11/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "MainRow.h"

@implementation MainRow

- (void)configureWithJSONItem:(JSONItem *)item atIndex:(NSUInteger)index
{
    [self.image setImage:[UIImage imageNamed:@"MusicNote"]];
    [self.label setText:[NSString stringWithFormat:@"%u - %@", index + 1, item.songTitle]];
}

@end

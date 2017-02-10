//
//  DetailController.m
//  Top10
//
//  Created by Cory Bohon on 12/11/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "DetailController.h"

@implementation DetailController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    JSONItem *detailItem = (JSONItem *)context;
    [self.songTitleLabel setText:detailItem.songTitle];
    
    [self.audioPreviewMovie setMovieURL:detailItem.audioPreviewURL];
    [self.audioPreviewMovie setPosterImage:[WKImage imageWithImageData:[NSData dataWithContentsOfURL:detailItem.imageURL]]];
    [self.audioPreviewMovie setLoops:NO];
}

@end

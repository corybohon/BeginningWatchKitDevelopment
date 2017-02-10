//
//  DetailController.m
//  Top10
//
//  Created by Cory Bohon on 12/11/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "DetailController.h"
@import WatchConnectivity;

@implementation DetailController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    JSONItem *detailItem = (JSONItem *)context;
    [self.songTitleLabel setText:detailItem.songTitle];
    
    [self.audioPreviewMovie setMovieURL:detailItem.audioPreviewURL];
    NSData *imageData = [NSData dataWithContentsOfURL:detailItem.imageURL];
    WKImage *image = [WKImage imageWithImageData:imageData];
    [self.audioPreviewMovie setPosterImage:image];
    [self.audioPreviewMovie setLoops:NO];
    
    // Save file locally, then transfer
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[filePaths firstObject] stringByAppendingPathComponent:[detailItem.imageURL lastPathComponent]];
    [[NSFileManager defaultManager] createFileAtPath:path contents:imageData attributes:nil];
    [[WCSession defaultSession] transferFile:[NSURL URLWithString:path] metadata:nil];
}

@end

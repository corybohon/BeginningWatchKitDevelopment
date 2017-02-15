//
//  JSONItem.m
//  Top10
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "JSONItem.h"

@implementation JSONItem

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.songTitle = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(songTitle))];
        self.artistName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(artistName))];
        self.albumName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(albumName))];
        self.genreTitle = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(genreTitle))];
        self.priceInUSD = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(priceInUSD))];
        self.releaseDate = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(releaseDate))];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.songTitle forKey:NSStringFromSelector(@selector(songTitle))];
    [aCoder encodeObject:self.artistName forKey:NSStringFromSelector(@selector(artistName))];
    [aCoder encodeObject:self.albumName forKey:NSStringFromSelector(@selector(albumName))];
    [aCoder encodeObject:self.genreTitle forKey:NSStringFromSelector(@selector(genreTitle))];
    [aCoder encodeObject:self.priceInUSD forKey:NSStringFromSelector(@selector(priceInUSD))];
    [aCoder encodeObject:self.releaseDate forKey:NSStringFromSelector(@selector(releaseDate))];
}

@end

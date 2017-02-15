//
//  JSONItem.h
//  Top10
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONItem : NSObject <NSCoding>

@property (nonatomic, strong) NSString *songTitle;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *genreTitle;
@property (nonatomic, strong) NSString *priceInUSD;
@property (nonatomic, strong) NSString *releaseDate;

@end

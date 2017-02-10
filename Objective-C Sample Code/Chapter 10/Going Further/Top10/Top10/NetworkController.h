//
//  NetworkController.h
//  Top10
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSONItem;

@interface NetworkController : NSObject

+ (instancetype)sharedNetworkController;
- (void)retrieveTopSong:(void(^)(NSError *error, JSONItem *topSong))completionHandler;
- (void)retrieveJSONFeedWithCompletionHandler:(void(^)(NSError *error, NSArray *objects))completionHandler forNumberOfItems:(NSUInteger)numberOfSongs;

@end

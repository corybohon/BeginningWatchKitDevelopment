//
//  NetworkController.m
//  Top10
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "NetworkController.h"
#import "JSONItem.h"

@interface NetworkController ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation NetworkController

+ (instancetype)sharedNetworkController
{
    static NetworkController *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        [sharedManager setupBaseSession];
    });
    
    return sharedManager;
}

#pragma mark - Internal Setup
- (void)setupBaseSession
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    [sessionConfig setHTTPAdditionalHeaders:@{@"Content-Type" : @"application/json", @"Accept" : @"application/json"}];
    
    self.session = [NSURLSession sessionWithConfiguration:sessionConfig];
}

#pragma mark - Methods 
- (void)retrieveTopSong:(void (^)(NSError *error, JSONItem *))completionHandler
{
    [self retrieveJSONFeedWithCompletionHandler:^(NSError *error, NSArray *objects) {
        if (!error && completionHandler) {
            completionHandler(nil, [objects firstObject]);
        }
    } forNumberOfItems:1];
}

- (void)retrieveJSONFeedWithCompletionHandler:(void(^)(NSError *error, NSArray  * _Nonnull objects))completionHandler forNumberOfItems:(NSUInteger)numberOfSongs
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/rss/topsongs/limit=%lu/json", numberOfSongs]]];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [self session];
    
    NSURLSessionTask *requestTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (error || (httpResponse.statusCode != 200)) {
            NSError *error = [NSError errorWithDomain:@"com.watchkit.test" code:300 userInfo:@{NSLocalizedDescriptionKey : @"Error retrieving JSON feed."}];
            
            if (completionHandler) {
                completionHandler(error, nil);
            }
        }
        
        __autoreleasing NSError *jsonResponseError;
        
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonResponseError];
        
        NSMutableArray *arrayToReturn = [[NSMutableArray alloc] init];
        
        if (numberOfSongs == 1) {
            NSDictionary *dictionary = jsonResponse[@"feed"][@"entry"];
            [arrayToReturn addObject:[self itemForDictionary: dictionary]];
        } else {
            for (NSDictionary *dictionary in jsonResponse[@"feed"][@"entry"]) {
                [arrayToReturn addObject:[self itemForDictionary:dictionary]];
            }
        }
        
        if (completionHandler) {
            completionHandler(nil, arrayToReturn);
        }
        
    }];
    [requestTask resume];
}

- (JSONItem *)itemForDictionary:(NSDictionary *)dictionary
{
    JSONItem *item = [[JSONItem alloc] init];
    item.artistName = dictionary[@"im:artist"][@"label"];
    item.albumName = dictionary[@"im:collection"][@"im:name"][@"label"];
    item.songTitle = dictionary[@"im:name"][@"label"];
    item.releaseDate = dictionary[@"im:releaseDate"][@"attributes"][@"label"];
    item.genreTitle = dictionary[@"category"][@"attributes"][@"label"];
    item.priceInUSD = dictionary[@"im:price"][@"attributes"][@"amount"];
    
    return item;
}

@end

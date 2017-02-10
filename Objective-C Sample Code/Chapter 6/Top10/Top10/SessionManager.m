//
//  SessionManager.m
//  Top10
//
//  Created by Cory Bohon on 12/13/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "SessionManager.h"
@import WatchConnectivity;

@interface SessionManager() <WCSessionDelegate>

@property (nonatomic, strong) WCSession *session;

@end

@implementation SessionManager

+ (instancetype)sharedManager
{
    static SessionManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        [sharedManager configureSession];
    });
    return sharedManager;
}

- (void)configureSession
{
    if (![WCSession isSupported]) {
        return;
    }
    
    self.session = [WCSession defaultSession];
    self.session.delegate = self;
    [self.session activateSession];
}

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error
{
    if (error) {
        NSLog(@"Unable to activate WCSession: %@", error.localizedDescription);
    }
}

- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file
{
    NSURL *fileToMoveURL = [file fileURL];
    
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [[filePaths firstObject] stringByAppendingPathComponent:[fileToMoveURL lastPathComponent]];
    
    NSURL *newLocationURL = [NSURL fileURLWithPath:path];
    
    __autoreleasing NSError *error = nil;
    
    [[NSFileManager defaultManager] moveItemAtURL:fileToMoveURL toURL:newLocationURL error:&error];
    
    if (error) {
        NSLog(@"Error Moving File: %@", error.localizedDescription);
    }
}

@end

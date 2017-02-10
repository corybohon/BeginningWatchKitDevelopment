//
//  ExtensionDelegate.m
//  Top10 WatchKit App Extension
//
//  Created by Cory Bohon on 12/5/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "ExtensionDelegate.h"

@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {
    // Perform any final initialization of your application.
}

- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive {
    [[WKExtension sharedExtension] scheduleSnapshotRefreshWithPreferredDate:[[NSDate date] dateByAddingTimeInterval:10] userInfo:nil scheduledCompletion:^(NSError * _Nullable error) {
        
        // TODO: Handle errors here
        
    }];
}

#pragma mark - Snapshots 
- (void)handleBackgroundTasks:(NSSet<WKRefreshBackgroundTask *> *)backgroundTasks
{
    for (WKSnapshotRefreshBackgroundTask *task in backgroundTasks) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"resetViewForSnapshot" object:nil];
        
        NSDate *newDate = [NSDate dateWithTimeIntervalSinceNow:3600];
        [task setTaskCompletedWithDefaultStateRestored:YES estimatedSnapshotExpiration:newDate userInfo:nil];
    }
}

@end

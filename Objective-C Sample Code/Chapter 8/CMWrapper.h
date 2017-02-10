//
//  CMWrapper.h
//  Top10
//
//  Created by Cory Bohon on 12/15/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreMotion;

@interface CMWrapper : NSObject

+ (instancetype)sharedInstance;

- (void)setAccelerometerBlock:(void (^)(CMAccelerometerData *accel, NSError *error))accelerometerBlock;
- (void)stopMonitoring;

@end

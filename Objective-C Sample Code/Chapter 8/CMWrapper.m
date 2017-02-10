//
//  CMWrapper.m
//  Top10
//
//  Created by Cory Bohon on 12/15/16.
//  Copyright © 2016 Cory Bohon. All rights reserved.
//

#import "CMWrapper.h"

@interface CMWrapper ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation CMWrapper

+ (instancetype)sharedInstance
{
    static CMWrapper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance setupWrapper];
    });
    
    return sharedInstance;
}

- (void)setupWrapper
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.operationQueue = [[NSOperationQueue alloc] init];
}

- (void)setAccelerometerBlock:(void (^)(CMAccelerometerData *, NSError *))accelerometerBlock
{
    [self.motionManager setAccelerometerUpdateInterval:0.1f];
    [self.motionManager startAccelerometerUpdatesToQueue:self.operationQueue withHandler:accelerometerBlock];
}

- (void)stopMonitoring
{
    [self.motionManager stopAccelerometerUpdates];
    [self.motionManager stopDeviceMotionUpdates];
    [self.motionManager stopGyroUpdates];
    [self.motionManager stopMagnetometerUpdates];
}

@end

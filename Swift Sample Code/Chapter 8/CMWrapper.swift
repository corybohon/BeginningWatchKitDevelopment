//
//  CMWrapper.swift
//  SampleApp
//
//  Created by Cory Bohon on 2/14/17.
//  Copyright © 2017 Cory Bohon. All rights reserved.
//

import UIKit
import CoreMotion

class CMWrapper: NSObject {

    static let shared = CMWrapper()
    var operationQueue: OperationQueue?
    var motionManager: CMMotionManager?
    
    override init() {
        super.init()
        self.setupWrapper()
    }

    func setupWrapper() {
        self.motionManager = CMMotionManager()
        self.operationQueue = OperationQueue()
    }
    
    func setAccelerometerBlock(accelerometerBlock: @escaping CMAccelerometerHandler) {
        self.motionManager?.accelerometerUpdateInterval = 0.1
        self.motionManager?.startAccelerometerUpdates(to: self.operationQueue!, withHandler: accelerometerBlock)
    }
    
    func stopMonitoring() {
        self.motionManager?.stopAccelerometerUpdates()
        self.motionManager?.stopDeviceMotionUpdates()
        self.motionManager?.stopGyroUpdates()
        self.motionManager?.stopMagnetometerUpdates()
    }
}

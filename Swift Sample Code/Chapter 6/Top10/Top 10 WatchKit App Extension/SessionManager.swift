//
//  SessionManager.swift
//  Top10
//
//  Created by Cory Bohon on 2/14/17.
//  Copyright © 2017 Cory Bohon. All rights reserved.
//

import UIKit
import WatchConnectivity

class SessionManager: NSObject, WCSessionDelegate {
    
    static let shared = SessionManager()
    var session: WCSession?
    
    override init() {
        super.init()
        self.configureSession()
    }
    
    func configureSession() {
        guard WCSession.isSupported() == true else {
            return
        }
        
        self.session = WCSession.default()
        self.session?.delegate = self
        self.session?.activate()
    }
    
    // MARK: - WCSessionDelegate 
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        if let error = error {
            print("Unable to activate WCSession: \(error.localizedDescription)")
        }
    }
}

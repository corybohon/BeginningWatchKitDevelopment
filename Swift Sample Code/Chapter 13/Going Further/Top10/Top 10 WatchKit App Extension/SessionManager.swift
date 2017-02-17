//
//  SessionManager.swift
//  Top10
//
//  Created by Cory Bohon on 2/14/17.
//  Copyright © 2017 Cory Bohon. All rights reserved.
//

import UIKit
import WatchConnectivity

class SessionManager: NSObject {
    
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
        self.session?.activate()
    }
    
    // MARK: - WCSessionDelegate 
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        if let error = error {
            print("Unable to activate WCSession: \(error.localizedDescription)")
        }
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        
        let fileToMoveURL: URL? = file.fileURL
        let filePaths: Array<String> = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path: String = (filePaths.first?.stringByAppendingPathComponent(pathComponent: fileToMoveURL!.lastPathComponent))!
        let newLocationURL: URL = URL(fileURLWithPath: path)
        
        do {
            try FileManager.default.moveItem(at: fileToMoveURL!, to: newLocationURL)
        } catch _ {
            print("Unable to move file")
        }
        
    }
}

extension String {
    func stringByAppendingPathComponent(pathComponent: String) -> String {
        return (self as NSString).appendingPathComponent(pathComponent)
    }
}

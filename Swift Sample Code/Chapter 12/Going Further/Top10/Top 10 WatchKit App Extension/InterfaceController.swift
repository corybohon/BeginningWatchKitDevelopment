//
//  InterfaceController.swift
//  Top 10 WatchKit App Extension
//
//  Created by Cory Bohon on 2/13/17.
//  Copyright © 2017 Cory Bohon. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable?
    @IBOutlet weak var backgroundGroup: WKInterfaceGroup?
    
    var jsonItems: Array<Any>?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.setTitle("Top 10")
        
        self.reloadData()
    }
    
    override func didAppear() {
        super.didAppear()
        self.backgroundGroup?.setBackgroundColor(.black)
        
        self.updateUserActivity("com.Top10.website", userInfo: nil, webpageURL: URL(string: "https://www.apple.com/itunes/charts/songs/"))
    }
    
    @IBAction func reloadData() {
        NetworkController.shared().retrieveJSONFeed(completionHandler: { (error, objects) in
            
            DispatchQueue.main.async {
                
                if error != nil {
                    self.presentAlert()
                }
                
                self.table?.insertRows(at: IndexSet(integersIn: 0..<10), withRowType: "MainRow")
                
                for row in 0..<10 {
                    let currentRow: MainRow = self.table?.rowController(at: row) as! MainRow
                    currentRow.configure(item: objects[row] as! JSONItem, index: row)
                    
                    currentRow.image?.setHidden(false)
                    currentRow.label?.setHidden(false)
                }
            }
            
            self.jsonItems = objects
            
        }, forNumberOfItems: 10)
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
        WKInterfaceDevice.current().play(.click)
        
        let jsonItem: JSONItem = self.jsonItems![rowIndex] as! JSONItem
        
        self.pushController(withName: "detailController", context: jsonItem)
    }
    
    func presentAlert() {
        let cancelAction: WKAlertAction = WKAlertAction(title: "Cancel", style: .cancel) { 
            // no handler needed
        }
        
        let retryAction: WKAlertAction = WKAlertAction(title: "Retry", style: .default) { 
            self.reloadData()
        }
        
        self.presentAlert(withTitle: nil, message: "Top 10 list currently unavailable", preferredStyle: .sideBySideButtonsAlert, actions: [cancelAction, retryAction])
    }
}

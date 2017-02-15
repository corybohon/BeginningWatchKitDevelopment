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
    
    var jsonItems: Array<Any>?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.setTitle("Top 10")
        
        self.reloadData()
    }
    
    @IBAction func reloadData() {
        NetworkController.shared().retrieveJSONFeed(completionHandler: { (error, objects) in
            
            self.table?.setNumberOfRows(10, withRowType: "MainRow")
            
            for row in 0..<10 {
                let currentRow: MainRow = self.table?.rowController(at: row) as! MainRow
                currentRow.configure(item: objects[row] as! JSONItem, index: row)
            }
            
            self.jsonItems = objects
            
        }, forNumberOfItems: 10)
    }
}

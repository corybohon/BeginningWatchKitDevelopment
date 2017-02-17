//
//  MainRow.swift
//  Top10
//
//  Created by Cory Bohon on 2/13/17.
//  Copyright © 2017 Cory Bohon. All rights reserved.
//

import UIKit
import WatchKit

class MainRow: NSObject {
    
    @IBOutlet weak var image: WKInterfaceImage?
    @IBOutlet weak var label: WKInterfaceLabel?
    
    func configure(item: JSONItem, index: Int) {
        self.image?.setImage(UIImage(named: "MusicNote"))
        self.label?.setText("\(index + 1) - \(item.songTitle!)")
    }
}

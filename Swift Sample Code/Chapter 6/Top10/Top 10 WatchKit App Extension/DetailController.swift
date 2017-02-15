//
//  DetailController.swift
//  Top10
//
//  Created by Cory Bohon on 2/14/17.
//  Copyright © 2017 Cory Bohon. All rights reserved.
//

import UIKit
import WatchKit

class DetailController: WKInterfaceController {
    
    @IBOutlet weak var songTitleLabel: WKInterfaceLabel?
    @IBOutlet weak var audioPreviewMovie: WKInterfaceMovie?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let detailItem: JSONItem = context as! JSONItem
        
        self.songTitleLabel?.setText(detailItem.songTitle)
        self.audioPreviewMovie?.setMovieURL(detailItem.audioPreviewURL)
        
        do {
            try self.audioPreviewMovie?.setPosterImage(WKImage(imageData: Data(contentsOf: detailItem.imageURL)))
        } catch _ {
            print("Unable to fetch image")
        }
        
        self.audioPreviewMovie?.setLoops(false)
    }
    
}

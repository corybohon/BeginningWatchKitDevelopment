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
            let imageData: Data = try Data(contentsOf: detailItem.imageURL)
            
            // Store the file locally, then transfer
            let fileName: String = detailItem.imageURL.lastPathComponent
            let filePaths: Array<String> = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path: String = (filePaths.first?.stringByAppendingPathComponent(pathComponent: fileName))!
            let newFileURL: URL = URL(fileURLWithPath: path)
            
            FileManager.default.createFile(atPath: path, contents: imageData, attributes: nil)
            SessionManager.shared.session?.transferFile(newFileURL, metadata: nil)
            self.audioPreviewMovie?.setPosterImage(WKImage(imageData: imageData))
            
        } catch _ {
            print("Unable to fetch image")
        }
        
        self.audioPreviewMovie?.setLoops(false)
    }
    
}

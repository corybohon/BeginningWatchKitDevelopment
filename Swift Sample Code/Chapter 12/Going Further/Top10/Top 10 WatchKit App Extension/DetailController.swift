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
    @IBOutlet weak var noteLabel: WKInterfaceLabel?
    @IBOutlet weak var emojiImage: WKInterfaceImage?
    
    var item: JSONItem?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        self.invalidateUserActivity()
        
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
        
        self.item = detailItem
    }
    
    override func didAppear() {
        super.didAppear()
        
        let input = UserDefaults.standard.object(forKey: (self.item?.songTitle)!)
        
        if let string: String = input as? String {
           self.noteLabel?.setText(string)
        }
        
        if let emoji: Data = input as? Data {
            self.emojiImage?.setImageData(emoji)
        }
        
        self.updateUserActivity("com.Top10.viewing", userInfo: ["object": self.item?.songTitle ?? ""], webpageURL: nil)
    }
    
    override func willDisappear() {
        super.willDisappear()
        self.invalidateUserActivity()
    }
    
    @IBAction func addNoteButtonTapped(sender: AnyObject) {
        let suggestions: Array<String> = ["Love this song", "This is a good song", "Meh", "Worst. Song. Ever."]
        
        self.presentTextInputController(withSuggestions: suggestions, allowedInputMode: .allowAnimatedEmoji) { (results: [Any]?) in
            
            if let unwrappedResults: Array<Any> = results {
                
                let input = unwrappedResults.first
                
                if let string: String = input as? String {
                    self.noteLabel?.setText(string)
                    self.emojiImage?.setImage(nil)
                }
                
                if let emoji: Data = input as? Data {
                    self.emojiImage?.setImageData(emoji)
                    self.noteLabel?.setText(nil)
                }
                
                UserDefaults.standard.set(unwrappedResults.first, forKey: (self.item?.songTitle)!)
            } else {
                print("Nothing returned")
            }
        }
    }
}

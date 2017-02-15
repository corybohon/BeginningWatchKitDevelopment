//
//  DetailViewController.swift
//  Top10
//
//  Created by Cory Bohon on 2/13/17.
//  Copyright © 2017 Cory Bohon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var songTitleLabel: UILabel?
    @IBOutlet weak var artistTitleLabel: UILabel?
    @IBOutlet weak var releaseDateLabel: UILabel?
    @IBOutlet weak var albumLabel: UILabel?
    @IBOutlet weak var genreNameLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?

    var detailItem: JSONItem? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    func configureView() {
        self.title = self.detailItem?.songTitle
        
        self.songTitleLabel?.text = self.detailItem?.songTitle
        self.artistTitleLabel?.text = self.detailItem?.artistName
        self.releaseDateLabel?.text = self.detailItem?.releaseDate
        self.albumLabel?.text = self.detailItem?.albumName
        self.genreNameLabel?.text = self.detailItem?.genreTitle
        self.priceLabel?.text = String(format: "%.2f", (self.detailItem?.priceInUSD)!)
    }

}


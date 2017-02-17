//
//  MasterViewController.swift
//  Top10
//
//  Created by Cory Bohon on 2/13/17.
//  Copyright © 2017 Cory Bohon. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var objects: Array<Any>?

    override func viewDidLoad() {
        self.title = "Top 10 Tunes"
        self.reloadContent(sender: self)
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            guard self.tableView.indexPathForSelectedRow != nil else {
                return
            }
            
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let detailItem: JSONItem = self.objects![indexPath.row] as! JSONItem
            
            let navigationController = segue.destination as! UINavigationController
            let destinationController = navigationController.viewControllers.first as! DetailViewController
            
            let detailController: DetailViewController = destinationController
            detailController.detailItem = detailItem
        }
    }
    
    @IBAction func reloadContent(sender: AnyObject) {
        NetworkController.shared().retrieveJSONFeed(completionHandler: { (error, objects) in
            
            self.objects = objects
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, forNumberOfItems: 10)
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard self.objects != nil else {
            return 0
        }
        
        return self.objects!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item: JSONItem = self.objects![indexPath.row] as! JSONItem
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(indexPath.row + 1) - \(item.songTitle!)"
        
        return cell
    }
    
    
}


//
//  MemeHistoryTableViewController.swift
//  MemeMe
//
//  Created by Ilia Tikhomirov on 15/12/15.
//  Copyright © 2015 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class MemeHistoryTableViewController: UITableViewController {
    
    @IBOutlet var tableHistoryView: UITableView!
    
    var memes: [Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(animated: Bool) {
        tableHistoryView!.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell", forIndexPath: indexPath) as! MemeTableViewCell

        // Configure the cell...
        cell.labelOutlet.text = memes[indexPath.row].top
        cell.imageOutlet.image = memes[indexPath.row].imageMemeStored
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
        
        detailController.imgD = memes[indexPath.row].imageMemeStored
        detailController.currentM = memes[indexPath.row]
        
        
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
                        let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableHistoryView!.reloadData()
            
            
            
        }
    }

}

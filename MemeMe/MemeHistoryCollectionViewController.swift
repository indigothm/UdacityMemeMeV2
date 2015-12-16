//
//  MemeHistoryCollectionViewController.swift
//  MemeMe
//
//  Created by Ilia Tikhomirov on 15/12/15.
//  Copyright © 2015 Ilia Tikhomirov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCell"

class MemeHistoryCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowL: UICollectionViewFlowLayout!
   
        
    @IBOutlet var collectionGrid: UICollectionView!
    
    var memes: [Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowL.minimumInteritemSpacing = space
        flowL.minimumLineSpacing = space
        flowL.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.collectionGrid!.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
    
        // Configure the cell
        cell.imageOutlet.image = memes[indexPath.row].imageMemeStored
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
        
        detailController.imgD = memes[indexPath.row].imageMemeStored
        detailController.currentM = memes[indexPath.row]
        
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }

}

//
//  DetailsViewController.swift
//  MemeMe
//
//  Created by Ilia Tikhomirov on 15/12/15.
//  Copyright © 2015 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var imgD: UIImage?
    var currentM: Meme?

    @IBOutlet weak var imgV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgV.image = imgD
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "onEdit:")
        
    }
    
    func onEdit(sender: AnyObject) {
        
        let editController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        editController.editMeme = currentM
        
        self.navigationController!.pushViewController(editController, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

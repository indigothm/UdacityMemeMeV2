//
//  ViewController.swift
//  MemeMe
//
//  Created by Ilia Tikhomirov on 15/09/15.
//  Copyright (c) 2015 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var keyboardSize: CGFloat!

    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var memeTextField: UITextField!
    @IBOutlet weak var memeTextFieldBottom: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var memeImageOutlet: UIImageView!
    
    @IBAction func cameraDidTouch(sender: UIBarButtonItem) {
        var newPicker = UIImagePickerController()
        newPicker.delegate = self
        newPicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(newPicker, animated: true, completion: nil)
    }
    
    @IBAction func albumDidTouch(sender: UIBarButtonItem) {
        var newPicker = UIImagePickerController()
        newPicker.delegate = self
        newPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(newPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.memeImageOutlet.image = image
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cameraButtonOutlet.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        let memeTextAttributes = [
            
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            //NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -3.0
        
        ]
        
        memeTextField.defaultTextAttributes = memeTextAttributes
        memeTextFieldBottom.defaultTextAttributes = memeTextAttributes
        memeTextField.textAlignment = .Center
        memeTextFieldBottom.textAlignment = .Center
        self.memeTextField.delegate = self
        self.memeTextFieldBottom.delegate = self
        
        
    }
    
    override func resignFirstResponder() -> Bool {
        if memeTextFieldBottom.editing {
            keyboardWillDissapear()
        }
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.subscribeToKeyboardNotifications()
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Textfield Management
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if memeTextFieldBottom.editing {
            keyboardWillDissapear()
        }
        self.view.endEditing(true)
        return false
    }
    
    
    //Keyboard shifting functionality
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        keyboardWillDissapear()
        NSNotificationCenter.defaultCenter().removeObserver(self,name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillDissapear() {
        
        // TODO: Fix the keyboard glitch
        
        self.view.frame.origin.y += keyboardSize
    }
    
    func keyboardWillShow(notification: NSNotification) {

        if memeTextFieldBottom.editing {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            keyboardSize = getKeyboardHeight(notification)
        }
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //Creating MemeMe Object
    
    func save() {
        
        let meme = Meme(textTop: memeTextField.text, textBottom: memeTextFieldBottom.text, image: imageView.image!)
        
        
    }
    
    // TODO: Implement image picker
    
    //Generating Merged Image
    
    func generateMemedImage() -> UIImage
    {
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO: Hide Toolbar and Navbar
        
        return memedImage
        
    }


}


//
//  ViewController.swift
//  MemeMe
//
//  Created by Ilia Tikhomirov on 15/09/15.
//  Copyright (c) 2015 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var keyboardSize: CGFloat = 0.0
    var editMeme: Meme?

    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var memeTextField: UITextField!
    @IBOutlet weak var memeTextFieldBottom: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var memeImageOutlet: UIImageView!
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    @IBAction func cancelDidTouch(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareDidTouch(sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let activity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activity.completionWithItemsHandler = {(activityType:String?, completed: Bool,
            returnedItems: [AnyObject]?, error: NSError?) in
            
            if (completed) {
                if activityType == UIActivityTypeSaveToCameraRoll {
                    print("save")
                    self.save()
                    activity.dismissViewControllerAnimated(true, completion: nil)
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }
            }
        }
        
        
        presentViewController(activity, animated: true, completion: nil)
        
    }
    
    @IBAction func cameraDidTouch(sender: UIBarButtonItem) {
        let newPicker = UIImagePickerController()
        newPicker.delegate = self
        newPicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(newPicker, animated: true, completion: nil)
    }
    
    @IBAction func albumDidTouch(sender: UIBarButtonItem) {
        let newPicker = UIImagePickerController()
        newPicker.delegate = self
        newPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(newPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        dismissViewControllerAnimated(true, completion: nil)
        memeImageOutlet.image = image
        shareButtonOutlet.enabled = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButtonOutlet.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        let memeTextAttributes = [
            
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -3.0
        
        ]
        
        memeTextField.defaultTextAttributes = memeTextAttributes
        memeTextFieldBottom.defaultTextAttributes = memeTextAttributes
        memeTextField.textAlignment = .Center
        memeTextFieldBottom.textAlignment = .Center
        
        memeTextField.delegate = self
        memeTextFieldBottom.delegate = self
        
        if let cm = editMeme {
            imageView.image = cm.image
            memeTextField.text = cm.top
            memeTextFieldBottom.text = cm.bottom
        }
        
        
    }
    
    override func resignFirstResponder() -> Bool {
        if memeTextFieldBottom.editing {
            keyboardWillDissapear()
        }
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
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
        view.endEditing(true)
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
                
        view.frame.origin.y += keyboardSize
    }
    
    func keyboardWillShow(notification: NSNotification) {

        if memeTextFieldBottom.editing {
            view.frame.origin.y -= getKeyboardHeight(notification)
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
        
        let meme = Meme(top: memeTextField.text!, bottom: memeTextFieldBottom.text!, image: imageView.image!, imageMemeStored: generateMemedImage())
        
        let object = UIApplication.sharedApplication().delegate
        
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        
    }
    
    func toolbarAppear (appearBool: Bool) {
        toolbar.hidden = appearBool
        navigationBar.hidden = appearBool
    }
    
    
    //Generating Merged Image
    
    func generateMemedImage() -> UIImage
    {
        
        toolbarAppear(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolbarAppear(false)
        
        return memedImage
        
    }


}


//
//  ViewController.swift
//  MemeMe
//
//  Created by Ilia Tikhomirov on 15/09/15.
//  Copyright (c) 2015 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var keyboardSize: CGFloat!

    @IBOutlet weak var memeTextField: UITextField!
    @IBOutlet weak var memeTextFieldBottom: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let memeTextAttributes = [
            
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: 3.0
        
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


}


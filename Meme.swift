//
//  Meme.swift
//  MemeMe
//
//  Created by Ilia Tikhomirov on 17/09/15.
//  Copyright (c) 2015 Ilia Tikhomirov. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    
    var top: String
    var bottom: String
    var image: UIImage
    
    var meme: UIView!
    
    init (textTop: String, textBottom: String, image: UIImage) {
        self.top = textTop
        self.bottom = textBottom
        self.image = image
    }
    
    
}
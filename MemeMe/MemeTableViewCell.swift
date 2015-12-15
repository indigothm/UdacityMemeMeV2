//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Ilia Tikhomirov on 15/12/15.
//  Copyright © 2015 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

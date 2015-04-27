//
//  SweetTableViewCell.swift
//  ParseTutorial
//
//  Created by Austin Murtha on 4/21/15.
//  Copyright (c) 2015 AustinMurtha. All rights reserved.
//

import UIKit

class SweetTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var sweetTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

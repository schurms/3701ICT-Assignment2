//
//  TextInputTableViewCell.swift
//  GettingThingsDone
//
//  Created by Sean Schurmann on 28/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

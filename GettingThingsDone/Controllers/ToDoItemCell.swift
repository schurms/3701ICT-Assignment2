//
//  ToDoItemCell.swift
//  GettingThingsDone
//
//  Created by Sean Schurmann on 25/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import UIKit

class ToDoItemCell: UITableViewCell {

    @IBOutlet weak var todoText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

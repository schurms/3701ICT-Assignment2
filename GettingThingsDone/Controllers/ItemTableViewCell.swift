//
//  ItemTableViewCell.swift
//  GettingThingsDone
//  Title: 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import UIKit

/**
 * UITableview cell subclass to allow editing of Title Records in a prototype cell
 */
class ItemTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    /**
     UITableViewCell Outlets
     */
    @IBOutlet weak var titleField: UITextField!
    
    /**
     Prepares the receiver
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    /**
     Set the state of the cell.
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

//
//  HistoryTableViewCell.swift
//  Title: GettingThingsDone App - 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 24/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import UIKit

/**
 * UITableview cell subclass to allow display and editing of History Records in a prototype cell
 */
class HistoryTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    /**
     UITableViewCell Outlets
     */
    @IBOutlet weak var historyDateField: UILabel!
    @IBOutlet weak var historyDescriptionField: UITextField!
    
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

//
//  DetailViewController.swift
//  GettingThingsDone
//  Title: 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import UIKit

//MARK: Protocols
/**
 Delegate protocol to send values back to ToDoListViewController for adding and updating to do items
 */
protocol ToDoItemDelegate {
    /**
     Edit Todo Information
     - Parameter todoItem: data to be provided to the didEditItem function
     */
    func didEditItem(_ controller: AnyObject, editItem: Item)
}

class DetailViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    // Declare headers
    let sectionHeaders = ["TASKS", "HISTORY", "COLLABORATORS", "PEERS"]
    enum Sections: Int {
        case sectionA = 0
        case sectionB = 1
        case sectionC = 2
        case sectionD = 3
    }
    
    // Delegate instance to return data back to MasterViewController
    var delegate: ToDoItemDelegate?
    
    // Item Variables
    var itemTitle: String = ""
    var itemHistory = [History]()
    var itemCollaborator = [Collaborator]()
    var itemPeer = [Peer]()
    var items = Item(title: "", done: false, itemHistory: [], itemCollaborator: [], itemPeer: [])

    // Counters and indexes
    var selectedRow: Int = 0
    var selectedSection: Int = 0
    var itemRows: Int = 1
    
    // Property observer if detailItem sent via showItem segue
    var detailItem: Item? {
        didSet {
            configureView()
        }
    }
    
    //MARK: Default View Load and Memory Handling Functions
    
    /**
     This method performs actions on view loading
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add right bar add button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addObject(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    /**
     This method is called on memory warnings
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    /**
     This method manages action on pressing keyboard return
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resign keyboard when return pressed
        textField.resignFirstResponder()
        return true
    }

    /**
     This method is called when editing of the textField commences
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // Hide navigation button if beginning to edit
        navigationItem.hidesBackButton = true
    }
    
    /**
     This method is called when editing of the textField completes.
     */
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        // Text field editing for Tasks
        if selectedSection == 0 {
            let indexPath = IndexPath(row: selectedRow, section: selectedSection)
            let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
            
            // Test for empty field by trimming whitespace and new lines from input text
            if let trimmedText = (cell.titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) {
                if trimmedText.isEmpty == false {
                    navigationItem.hidesBackButton = false
                    itemTitle = trimmedText
                }
            }
        }
    }
    
    
    // MARK: Table View
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
    /**
     This method enables the number of sections
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //MARK: Properties
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Number of Rows for Task Section
        if section == 0 {
            return 1
        
        // Number of Rows for History Section
        } else if section == 1 {
            return itemHistory.count
            
        // Number of Rows for Collaborator Section
        } else if section == 2 {
            return itemCollaborator.count
            
        // Number of Rows for Peer Section
        } else {
            return itemPeer.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Define prototype cell reuse identifier as set in the View
        let identifier: String
        guard let section = Sections(rawValue: indexPath.section) else {
            fatalError("Unexpectedly got section \(indexPath.section)")
        }
        switch section {
        case .sectionA:
            identifier = "TaskCell"
        case .sectionB:
            identifier = "HistoryCell"
        case .sectionC:
            identifier = "CollaboratorCell"
        case .sectionD:
            identifier = "PeerCell"
        }

        selectedRow = indexPath.row
        selectedSection = indexPath.section
        
        // Task Section
        if (indexPath.section == 0) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ItemTableViewCell
            cell.titleTextField.text = itemTitle
    
            // Return populated cell to TableView
            return cell
            
        // History Section
        } else if (indexPath.section == 1) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            let itemHistoryDesc = itemHistory[indexPath.row].historyDescription
            cell.textLabel!.text = itemHistoryDesc
            
            // Return populated cell to TableView
            return cell

        // Collaborator Section
        } else if (indexPath.section == 2) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ItemTableViewCell
            cell.titleTextField.text = itemTitle
            
            // Return populated cell to TableView
            return cell
            
        // Peer Section
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ItemTableViewCell
            cell.titleTextField.text = itemTitle
            
            // Return populated cell to TableView
            return cell
        }
    }
    
    /**
     This method is called on view Disappearing - Returning to Master
     */
    override func viewWillDisappear(_ animated: Bool) {

        // Return edited data back via the protocol
        if delegate != nil {
            
            // Set up variables to return
            items.title = itemTitle
            
            // Add changes to array
            delegate?.didEditItem(self, editItem: items)
        }
    }
    
    //MARK: Helper Methods
    
    /**
     Configures the view variables
     - returns: Sets view Variables
     */
    func configureView() {
        
        // Set variables passed from Master Table
        if let detail = detailItem {
            itemTitle = detail.title
            itemHistory = detail.itemHistory
            itemCollaborator = detail.itemCollaborator
            itemPeer = detail.itemPeer
        }
    }
    
    // Called on pressing the add Button - To Implement
    @objc func addObject(_ sender: Any) {
        
    }
    
}

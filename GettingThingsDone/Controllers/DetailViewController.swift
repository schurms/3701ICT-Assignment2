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
    var eventHistory = History(historyDate: Date(), historyDescription: "")
    var itemCollaborator = Collaborator(collaboratorName: "")
    var itemPeer = Peer(peerName: "", peerDevice: "")
    var items = Item(title: "", done: false, itemHistory: [], itemCollaborator: [], itemPeer: [])
    var itemTitle: String = ""
    var selectedRow: Int = 0
    var selectedSection: Int = 0
    
    // Property observer if detailItem sent via showItem segue
    var detailItem: Item? {
        didSet {}
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
            let cell = tableView.cellForRow(at: indexPath) as! TextInputTableViewCell
            
            // Test for empty field by trimming whitespace and new lines from input text
            if let trimmedText = (cell.taskTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) {
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
        return 1
    }
    
    //MARK: Properties
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
    
            let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextInputTableViewCell
            if let detail = detailItem {
                cell.taskTextField.text = detail.title
                itemTitle = detail.title
            }
            return cell
    
        // Return populated cell to TableView
        
    }
    
    /**
     This method is called on view Disappearing - Returning to Master
     */
    override func viewWillDisappear(_ animated: Bool) {

        // Return edited data back via the protocol
        if delegate != nil {
           
            items.title = itemTitle

            delegate?.didEditItem(self, editItem: items)
        }
    }
    
    //MARK: Helper Methods
    
    // Called on pressing the add Button - To Implement
    @objc func addObject(_ sender: Any) {
        
    }
    
}

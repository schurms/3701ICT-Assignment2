//
//  DetailViewController.swift
//  Title: GettingThingsDone App - 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import UIKit

//MARK: Protocols
/**
 Delegate protocol to send values back to ToDoListViewController for adding and updating to do items
 */
protocol ToDoItemDelegate: class {
    
    /**
     Edit Todo Information
     - Parameter Item: Data to be provided to the didEditItem function and sent to peers
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
    weak var delegate: ToDoItemDelegate?
    
    // Item Variables
    var itemUUID: UUID = UUID()
    var itemTitle: String = ""
    var itemTitleChanged: String = ""
    var itemDone: Bool = false
    var itemHistory = [History]()
    var itemCollaborator = [Collaborator]()
    var itemPeer = [Peer]()
    var items = Item(itemIdentifier: UUID(), title: "", done: false, itemHistory: [], itemCollaborator: [])
    
    // Property observer for Item Details sent via showItem segue
    var detailItem: Item? {
        didSet {
            configureItemView()
        }
    }
    
    // Property observer for Peer Details sent via showItem segue
    var detailPeer = [Peer]() {
        didSet {
            configurePeerView()
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
        if (textField.tag == 1) {
            
            // Set cell being edited
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
            
            // Test for empty field by trimming whitespace and new lines from input text
            if let trimmedText = (cell.titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) {
                
                // If text is empty do not enable the back button
                if trimmedText.isEmpty == false {
                    navigationItem.hidesBackButton = false
                }
                
                // Update the item Title
                itemTitle = trimmedText
            }
            
            // Test if Title changed
            if itemTitleChanged != itemTitle {
                
                // Set up new history record when title changed - Not editable
                let histDesc = "*Changed to \(itemTitle)"
                let newHistory = History(historyDate: Date(), historyDescription: histDesc, historyEditable: false)
                
                // Append item to history array
                itemHistory.append(newHistory)
                
                // Set new title variable to be changed title
                itemTitleChanged = itemTitle
            }
            
            // Reload table data
            tableView.reloadData()

            // Return edited data back via the protocol
            updateTableData()
            
            // Text field editing for History
        } else if (textField.tag == 2) {
            
            // Get the Row and Section for the textfield cell
            let origin: CGPoint = textField.frame.origin
            let point: CGPoint? = textField.superview?.convert(origin, to: tableView)
            let indexCell: IndexPath? = tableView.indexPathForRow(at: point ?? CGPoint.zero)
            
            // unwrap optional
            if let itemCell = indexCell {
                
                // Set cell being edited
                let indexPath = IndexPath(row: itemCell.row, section: itemCell.section)
                let cell: HistoryTableViewCell = self.tableView.cellForRow(at: indexPath) as! HistoryTableViewCell
                
                // Test for empty field by trimming whitespace and new lines from input text
                if let trimmedText = (cell.historyDescriptionField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) {
                    
                    // If text is empty do not enable the back button
                    if trimmedText.isEmpty == false {
                        navigationItem.hidesBackButton = false
                        
                        // Update the history description
                        itemHistory[itemCell.row].historyDescription = trimmedText
                    }
                }
            }
        }
        // Reload table data
        tableView.reloadData()
        
        // Update variables and update master view on finishing editing
        updateTableData()
    }
    
    //MARK: Table View Datasource methods
    
    /**
     This method returns the headers for each section
     */
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // Return required section header
        return sectionHeaders[section]
    }
    
    /**
     This method activates the required number of sections based on the number of headers
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // Return the number of sections
        return sectionHeaders.count
    }
    
    /**
     This method returns the number of rows for a section
     */
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
    
    /**
     This method displays the rows of data
     */
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
        
        // Task Section
        if (indexPath.section == 0) {
            
            // Set cell to Task Custom Cell
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ItemTableViewCell else {
                fatalError("Unexpectedly got section\row \(indexPath.section) \(indexPath.row)")
            }
            
            // Get cell data
            cell.titleField.text = itemTitle
            
            // Set variable to test if itemTitle is updated
            itemTitleChanged = itemTitle
            
            // Return populated cell to TableView
            return cell
            
            // History Section
        } else if (indexPath.section == 1) {
            
            // Set cell to History Custom Cell
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? HistoryTableViewCell else {
                fatalError("Unexpectedly got section\row \(indexPath.section) \(indexPath.row)")
            }
            
            // Get cell data
            cell.historyDateField.text = Utility.dateToString(itemHistory[indexPath.row].historyDate)
            cell.historyDescriptionField.text = itemHistory[indexPath.row].historyDescription
            
            // Disable field editing if it is a system generated history record
            if (itemHistory[indexPath.row].historyEditable == false) {
                cell.historyDescriptionField.isUserInteractionEnabled = false
            }
            
            // Return populated cell to TableView
            return cell
            
            // Collaborator Section
        } else if (indexPath.section == 2) {
            
            // Set cell to Collaborator Cell
            let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            
            // Get cell data
            cell.textLabel?.text = itemCollaborator[indexPath.row].collaboratorName
            // Return populated cell to TableView
            return cell
            
            // Peer Section
        } else {
            
            // Set cell to Peer Cell
            let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            
            // Get cell data
            cell.textLabel?.text = itemPeer[indexPath.row].peerUser
            cell.detailTextLabel?.text = itemPeer[indexPath.row].peerDevice
            
            // Return populated cell to TableView
            return cell
        }
    }
    
    /**
     This method Converts Peers to Collaborators and Sends data to collaborators
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // If selecting Peer row
        if indexPath.section == 3 {
            
            // Set up new collaborator record when peer pressed
            let collaboratorName = itemPeer[indexPath.row].peerUser
            let collaboratorDevice = itemPeer[indexPath.row].peerDevice
            let newCollaborator = Collaborator(collaboratorName: collaboratorName, collaboratorDevice: collaboratorDevice)

            // Append collaborator to collaborator array
            itemCollaborator.append(newCollaborator)
            
            // Remove the Peer from the list
            itemPeer.remove(at: indexPath.row)

            // Set up new history record when Collaborator added
            let histDesc = "*Added \(collaboratorName)"
            let newHistory = History(historyDate: Date(), historyDescription: histDesc, historyEditable: false)
            
            // Append item to history array
            itemHistory.append(newHistory)
        }
        
        // Update and Send data
        updateTableData()
        
        // Deselect row after row clicked
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Reload table view
        tableView.reloadData()
    }
    
    /**
     This method is called on view Disappearing - Returning to Master
     The function returns updated data back for updating
     */
    override func viewWillDisappear(_ animated: Bool) {
        
        // Update and send data
        updateTableData()
    }
    
    //MARK: Helper Methods
    
    /**
     Configures data to return to MasterView
     - Return data for editing
     */
    func updateTableData() {
        // Return edited data back via the protocol
        if delegate != nil {

            // Set up variables to return
            items.itemIdentifier = itemUUID
            items.title = itemTitle
            items.done = itemDone
            items.itemHistory = itemHistory
            items.itemCollaborator = itemCollaborator
            
            // Add changes to array
            delegate?.didEditItem(self, editItem: items)
        }
        
    }
    
    /**
     Configures the Item view variables
     - returns: Sets view Variables
     */
    func configureItemView() {
        
        // Set variables passed from MasterViewController and assign to DetailViewController variables
        if let detail = detailItem {
            itemUUID = detail.itemIdentifier
            itemTitle = detail.title
            itemDone = detail.done
            itemHistory = detail.itemHistory
            itemCollaborator = detail.itemCollaborator
        }
    }
    
    /**
     Configures the Peer view variables
     - returns: Sets view Variables
     */
    func configurePeerView() {
        
        // Set variables passed from MasterViewController and assign to DetailViewController variables
        let detail = detailPeer
        itemPeer = detail
        
        // If the peer is already a collaborator then remove it from the peers list before displaying view
        for item in itemCollaborator {
            for (index,peer) in itemPeer.enumerated() {
                if (item.collaboratorDevice == peer.peerDevice) && (item.collaboratorName == peer.peerUser) {
                    itemPeer.remove(at: index)
                }
            }
        }
    }
    
    /**
     This methods triggers from the add button. It inserts a new history object into the array
     - Parameter sender: triggers from self
     */
    @objc func addObject(_ sender: Any) {
        
        // Set up new history record when add history pressed
        let newHistory = History(historyDate: Date(), historyDescription: "New History Record", historyEditable: true)
        
        // Append item to history array
        itemHistory.append(newHistory)
        
        // Reload table data
        tableView.reloadData()
        
        // Update variables and update master view on finishing editing
        updateTableData()
    }
    
}

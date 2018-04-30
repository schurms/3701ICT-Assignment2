///
//  MasterViewController.swift
//  GettingThingsDone
//  Title: 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import UIKit

/**
 * This class defines the Master View Controller for the GettingThingsDone application.
 * Class conforms to the ToDoItemDelegate protocol used in the DetailViewController.
 */

class MasterViewController: UITableViewController, ToDoItemDelegate {
    
    //MARK: Properties
    
    // Delegate
    weak var detailViewController: DetailViewController?
    
    // Declare arrays
    var items = [[Item](), [Item]()]
    var itemDone: Bool = false
    var itemHistory = History(historyDate: Date(), historyDescription: "Item Created", historyEditable: false)
    var itemCollaborator = Collaborator(collaboratorName: "")
    var itemPeer = Peer(peerName: "", peerDevice: "")
    var item = Item(title: "", done: false, itemHistory: [], itemCollaborator: [], itemPeer: [])
    
    // Declare headers arrays
    let sectionHeaders = ["YET TO DO", "COMPLETED"]
    
    // Declare variables
    var todoCounter: Int = 0
    var selectedRow: Int = 0
    var selectedSection: Int = 0
    
    
    /**
     This method performs actions on view loading
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    /**
     Default actions on appearance of splitViewController
     */
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    /**
     This method is called on memory warnings
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     This methos triggers from the add button.  It inserts a new object into the array
     */
    @objc func insertNewObject(_ sender: Any) {
        
        // Set up initial Title Record
        todoCounter += 1
        item.title = "Todo Item \(todoCounter)"
        
        // Append record to Array
        items[0].append(Item(title: item.title, done: item.done, itemHistory: [itemHistory], itemCollaborator: [], itemPeer: []))
        tableView.reloadData()
    }
    
    //MARK: Table View Datasource Method
    
    /**
     This method returns the headers for each section
     */
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
    /**
     This method enables the number of sections
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }
    
    /**
     This method returns the number of rows for a section
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    /**
     This method displays the rows of data
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "ToDoItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
//        let itemHistoryDate = items[indexPath.section][indexPath.row].itemHistory[0].historyDate
//        let itemHistoryDesc = items[indexPath.section][indexPath.row].itemHistory[0].historyDescription
        
        let item = items[indexPath.section][indexPath.row]
        
        cell.textLabel!.text = item.title

        return cell
    }
    
    /**
     This method sets a row as editable
     */
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    /**
     This method enables row delete
     */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: TableView Delegate Methods
    
    /**
     Set Action to be able to move row
     */
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /**
     Method to move rows between sections - Yet To Do / Completed
     */
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let itemToMove = self.items[sourceIndexPath.section][sourceIndexPath.row]
        
        // Delete the todo from source section
        items[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        
        // Move the todo to the target section
        items[destinationIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
        
        // Update the done flag depending on item moved
        if (sourceIndexPath.section == 0 && destinationIndexPath.section == 1) {
            
            // Item moved to "Completed" - set done = True
            items[destinationIndexPath.section][destinationIndexPath.row].done = true
            
            // Add history record for move to "Completed"
            itemHistory = History(historyDate: Date(), historyDescription: "Item Completed", historyEditable: false)
            items[destinationIndexPath.section][destinationIndexPath.row].itemHistory.append(itemHistory)
            
        } else if ( sourceIndexPath.section == 1 && destinationIndexPath.section == 0) {
            
            // Item moved to "Yet To Do" - set done = False
            items[destinationIndexPath.section][destinationIndexPath.row].done = false
            
            // Add history record for move to "Yet To Do"
            itemHistory = History(historyDate: Date(), historyDescription: "Item Not Completed", historyEditable: false)
            items[destinationIndexPath.section][destinationIndexPath.row].itemHistory.append(itemHistory)
        }
    }
    
    //MARK: Segues
    
    /**
     This method actions the segue
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                selectedSection = indexPath.section
                selectedRow = indexPath.row
                let selectedItem = items[selectedSection][selectedRow]
                let destinationViewController = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                destinationViewController.delegate = self
                destinationViewController.detailItem = selectedItem
                destinationViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                destinationViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    //MARK: Protocol Delegate Methods
    
    /**
     This Delegate method is used to update an existing item in the Items array
     - Parameter controller: Defines the sending view controller
     - Parameter editItem: Contains the item values to be edited in the array
     - returns: Updated items
     */
    func didEditItem(_ controller: AnyObject, editItem: Item) {
        
        // Replace the edited item in the array at the row that was selected
        items[selectedSection][selectedRow] = editItem
        
        // Reload table view
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

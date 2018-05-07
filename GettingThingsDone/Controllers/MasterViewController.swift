///
//  MasterViewController.swift
//  GettingThingsDone
//  Title: 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import UIKit
import MultipeerConnectivity

/**
 * This class defines the Master View Controller for the GettingThingsDone application.
 * Class conforms to the ToDoItemDelegate protocol used in the DetailViewController.
 */

class MasterViewController: UITableViewController, ToDoItemDelegate, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    
    //MARK: Properties
    
    // Declare delegate
    weak var detailViewController: DetailViewController?
    
    // Declare arrays
    var itemArray = [[Item](), [Item]()]
    var peerArray = [Peer]()
    var collaboratorArray = [Collaborator]()
    var itemDone: Bool = false
    var itemHistory = History(historyDate: Date(), historyDescription: "*Item Created", historyEditable: false)
    var itemCollaborator = Collaborator(collaboratorName: "")
    var itemPeer = Peer(peerName: "", peerDevice: "")
    var item = Item(itemIdentifier: UUID(), title: "", done: false, itemHistory: [])
    
    // Multipeer variables
    let itemServiceType = "s5073958"
    
    var sessionID: MCSession!
    var peerID: MCPeerID!
    var browserID: MCNearbyServiceBrowser!
    var advertiserID: MCNearbyServiceAdvertiser!
    
    var foundPeers = [MCPeerID]()
    var invitationHandler: ((Bool, MCSession?)->Void)!
    
    // Declare headers arrays
    let sectionHeaders = ["YET TO DO", "COMPLETED"]
    
    // Declare variables used
    var todoCounter: Int = 0
    var selectedRow: Int = 0
    var selectedSection: Int = 0
    
    /**
     This method performs actions on view loading - Standard method
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Set up add button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        // Set up split view controller
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        let centre = NotificationCenter.default
        centre.addObserver(forName: resignNotification, object: nil, queue: nil) { _ in
            print("Saving my data (or pretending to)")
        }
        
        // Initalise Multipeer Variables
        peerID = MCPeerID(displayName: UIDevice.current.name)
        
        sessionID = MCSession(peer: peerID)
        sessionID.delegate = self
        
        browserID = MCNearbyServiceBrowser(peer: peerID, serviceType: itemServiceType)
        browserID.delegate = self
        
        advertiserID = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: itemServiceType)
        advertiserID.delegate = self
        
        browserID.startBrowsingForPeers()
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
     This methods triggers from the add button. It inserts a new object into the array
     - Parameter sender: triggers from self
     */
    @objc func insertNewObject(_ sender: Any) {
        
        // Set up item Title record - increment counter
        todoCounter += 1
        let title = "Todo Item \(todoCounter)"
        let item = Item(itemIdentifier: UUID(), title: title, done: self.item.done, itemHistory: [itemHistory])
        // Append new record to Array - null arrays for other information
        itemArray[0].append(item)
        
        // Reload tableviewlet
        tableView.reloadData()
        
        // Test Collaborator Array
        let nameCollaborator = "Test Collaborator \(todoCounter)"
        let itemCollaborator = Collaborator(collaboratorName: nameCollaborator)
        collaboratorArray.append(itemCollaborator)
        
    }
    
    //MARK: Multi-peer Delegate Methods
    
    /**
     * Called when a nearby Peer is found
     */
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        foundPeers.append(peerID)
        let peerDevice = peerID.displayName
        print(peerID.displayName, peerID.description)
        let peer = Peer(peerName: itemServiceType, peerDevice: peerDevice)
        peerArray.append(peer)
    }
    
    /**
     * Called when a nearby Peer is lost
     */
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        for (index, aPeer) in foundPeers.enumerated() {
            if aPeer == peerID {
                foundPeers.remove(at: index)
                break
            }
        }
    }
    
    /**
     * Called when a browser failed to start browsing for peers
     */
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print(error.localizedDescription)
    }
    
    /**
     * Called when an advertisement fails
     */
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
    }
    
    /**
     * Called when an invitation to join a session is received from a nearby Peer
     */
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("didReceiveInvitationFromPeer \(peerID)")
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected to session: \(session)")
        case MCSessionState.connecting:
            print("Connecting to session: \(session)")
        case MCSessionState.notConnected:
            print("Did not connect to session: \(session)")
        }
    }
    
    /**
     * Indicates that the data task has received some of the expected data
     */
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    }
    
    /**
     * Indicates that the input streams are available
     */
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    /**
     * Indicates that the local Peer finished receiving a resource from a nearby Peer
     */
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    /**
     * Indicates that the local Peer finished receiving a resource from a nearby Peer
     */
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
    
    //MARK: Table View Datasource Method
    
    /**
     This method returns the headers for each section
     */
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // Return required section header
        return sectionHeaders[section]
    }
    
    /**
     This method enables the number of sections
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // Return the number of sections
        return sectionHeaders.count
    }
    
    /**
     This method returns the number of rows for a section
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of rows for each section
        return itemArray[section].count
    }
    
    /**
     This method displays the rows of data
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Define prototype cell reuse identifier as set in the View
        let cellReuseIdentifier = "ToDoItemCell"
        
        // Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        // Fetches the appropriate item for the data source layout from the items array
        let item = itemArray[indexPath.section][indexPath.row]
        
        // Configure the itemTitle Cell
        cell.textLabel!.text = item.title
        
        // Return populated cell to TableView
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
        
        // Allow deletion of items if canEditRowAt = true
        if editingStyle == .delete {
            
            // Delete selected row from data source.
            itemArray[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: TableView Delegate Methods
    
    /**
     Set Action to be able to move row
     */
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        // Return true if can move row - this is the default
        return true
    }
    
    /**
     Method to move rows between sections - Yet To Do / Completed
     */
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // Select item to move
        let itemToMove = self.itemArray[sourceIndexPath.section][sourceIndexPath.row]
        
        // Delete the item from source section
        itemArray[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        
        // Move the item to the target section
        itemArray[destinationIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
        
        // Update the done flag depending on item moved
        if (sourceIndexPath.section == 0 && destinationIndexPath.section == 1) {
            
            // Item moved to "Completed" - set done = True
            itemArray[destinationIndexPath.section][destinationIndexPath.row].done = true
            
            // Add history record for move to "Completed"
            itemHistory = History(historyDate: Date(), historyDescription: "*Item Completed", historyEditable: false)
            itemArray[destinationIndexPath.section][destinationIndexPath.row].itemHistory.append(itemHistory)
            
        } else if ( sourceIndexPath.section == 1 && destinationIndexPath.section == 0) {
            
            // Item moved to "Yet To Do" - set done = False
            itemArray[destinationIndexPath.section][destinationIndexPath.row].done = false
            
            // Add history record for move to "Yet To Do"
            itemHistory = History(historyDate: Date(), historyDescription: "*Item Not Completed", historyEditable: false)
            itemArray[destinationIndexPath.section][destinationIndexPath.row].itemHistory.append(itemHistory)
        }
    }
    
    /**
     This method is a test method to test saving and retrieving from JSON on selection
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemArray[indexPath.section][indexPath.row]
        item.saveItemToJSON(item)
        
        //        let itemIn = item.getItemFromJSON()
        //        print("Reading in data for this item \(itemIn.title)")
        
    }
    
    //MARK: Segues
    
    /**
     This method actions the segue
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // If showDetail segue
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                // Set the selected row and section variables for later reuse
                selectedSection = indexPath.section
                selectedRow = indexPath.row
                
                // Get the selected item to pass
                let selectedItem = itemArray[selectedSection][selectedRow]
                // Get the selected item to pass
                let selectedCollaborator = collaboratorArray
                let selectedPeer = peerArray
                
                // Set the destination ViewController
                let destinationViewController = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                // Set destination view controller as delegate for self
                destinationViewController.delegate = self
                
                // Set the data to be transferred
                destinationViewController.detailItem = selectedItem
                destinationViewController.detailCollaborator = selectedCollaborator
                destinationViewController.detailPeer = selectedPeer
                
                // Set the destination view controller bar button item for return
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
        itemArray[selectedSection][selectedRow] = editItem
        
        // Reload table view
        tableView.reloadData()
    }
    
}

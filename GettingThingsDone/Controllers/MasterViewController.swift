//
//  MasterViewController.swift
//  GettingThingsDone
//  Title: 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, DetailItemControllerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    
    let sections: [String] = ["YET TO DO", "COMPLETED"]
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func insertNewObject(_ sender: Any) {
        let indexPath = IndexPath(row: objects.count, section: 0)
//        let indexPath2 = IndexPath(row: objects.count, section: 1)  // what is the error here
        let objectCounter = objects.count + 1
        objects.append("Todo Item \(objectCounter)")
//        tableView.insertRows(at: [indexPath,indexPath2], with: .automatic)
        tableView.insertRows(at: [indexPath], with: .automatic)

    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object as? String
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // change to 2 and it crashes
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = (object as AnyObject).description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: Moving Cells
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todoToMove = self.objects[sourceIndexPath.row]
        
        objects.remove(at: sourceIndexPath.row)
        objects.insert(todoToMove, at: destinationIndexPath.row)
    }
    
    //MARK: Protocol Delegate Methods
    
    /**
     This Delegate method is used to update an existing item in the Items array
     - Parameter controller: Defines the sending view controller
     - Parameter editItem: Contains the item values to be edited in the array
     - returns: The ToDoListViewController is returned with the tableview reloaded
     */
    func editItem(_ controller: AnyObject, editItem: Todo) {
        
        // Replace the edited item in the array at the row that was selected
       // todos[selectedRow] = editItem
        
        // Reload table view
        tableView.reloadData()
        
        // Use dismiss to remove the intermediate UIController for this segue
        dismiss(animated: true, completion: nil)
    }
    
}



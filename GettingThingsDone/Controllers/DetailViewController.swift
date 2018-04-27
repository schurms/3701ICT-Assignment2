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
    
    // Delegate instance to return data back to MasterViewController
    var delegate: ToDoItemDelegate?
    var items = Item(title: "", done: false)
    
    // Property observer if detailItem sent via showItem segue
    var detailItem: Item? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    //MARK: Outlets
    
    /**
     Outlets to capture and display information
     */
    @IBOutlet weak var itemTitle: UITextField!
    
    //MARK: Default View Load and Memory Handling Functions
    
    /**
     This method performs actions on view loading
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Let itemTitle field be delegate for ViewController
        itemTitle?.delegate = self
        
        // Add right bar add button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        // Set up view
        configureView()
    }
    
    /**
     This method is called on memory warnings
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     This method is called on view Disappearing - Returning to Master
     */
    override func viewWillDisappear(_ animated: Bool) {
        
        // Return edited data back via the protocol
        if delegate != nil {
            if let trimmedText = itemTitle?.text {
                items.title = trimmedText
            } else {
                fatalError("Can not read input text")
            }
            delegate?.didEditItem(self, editItem: items)
            
        }
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
    
    //MARK: Helper Methods
    
    // Configure the User view
    func configureView() {
        // Update the user interface for the detail item.
        if let item = detailItem {
            itemTitle?.text = item.title
        }
    }
    
    // Called on pressing the add Button - To Implement
    @objc func addObject(_ sender: Any) {
        
    }
    
}

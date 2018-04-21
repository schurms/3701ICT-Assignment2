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
protocol DetailItemControllerDelegate: class {
    /**
     Edit an existing item
     - Parameter controller: Name of initiating controller
     - Parameter editItem: data to be provided to editItem function in ToDoListViewController
     */
    func editItem(_ controller: AnyObject, editItem: Todo)
}

class DetailViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    // Delegate instance to return data back to ToDoListViewController
    weak var delegate: DetailItemControllerDelegate?
    
    // Define and initialise a new array object
    var todos = Todo(title: "" )
    
    //MARK: Outlets
    
    /**
     Outlets to capture and display information
     */
    
    @IBOutlet weak var todoText: UITextField!
    
    // Property observer if detailItem sent via showItem segue
    var detailItem: String? { // using string temporarily
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let todoTitle = todoText {
                todoTitle.text = detail.description
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add right bar add button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(editObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    /**
     This method manages action on pressing return
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resign keyboard when return pressed
        textField.resignFirstResponder()
        return true
    }
    

    @objc func editObject(_ sender: Any) {

    }
    
}

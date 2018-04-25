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
    func didEditItem(todoItem: String)
}

class DetailViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    // Delegate instance to return data back to ToDoListViewController
    var delegate: ToDoItemDelegate?
    
    
    /**
     Outlets to capture and display information
     */
    
    @IBOutlet weak var todoText: UITextField!
    
    // Property observer if detailItem sent via showItem segue
    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    // Configure the User view
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
        
        // Let itemTitle field be delegate for ToDoItemViewController
        todoText?.delegate = self
        
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
    
    override func viewWillDisappear(_ animated: Bool) {

        if delegate != nil {
            if let editedToDo = todoText?.text {
                print(editedToDo)
                delegate?.didEditItem(todoItem: editedToDo)
            }
        }
        
    }
    
    @objc func editObject(_ sender: Any) {
        

    }
    
}

//
//  ViewController.swift
//  Todoey
//
//  Created by Orkun Düzgün on 1.02.2018.
//  Copyright © 2018 Orkun Duzgun. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let userDefaults = UserDefaults.standard

    //We didn't add IBOutlet for ListView because our class is a sublass of UITableViewController
    
    var itemArray = ["Learn iOS","Create CryptoTrackr iOS","Get rich"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = userDefaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
    
    //MARK: Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //mARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            
            self.userDefaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Type new item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil )
        
    }

}


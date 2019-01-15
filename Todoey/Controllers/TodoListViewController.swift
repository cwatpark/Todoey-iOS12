//
//  ViewController.swift
//  Todoey
//
//  Created by Ice on 15/1/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//
import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard // -----------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Mickie"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Egg"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)

        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{  //----------------------
            itemArray = items
        }
        
    }
    
    //MARK - Tableview Datasource Medthods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
    }

    //MARK - TableView Delegate Medthods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }else{
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //var UserText : String = ""
        var TextField = UITextField()
        let alert = UIAlertController(title: "Add new ToDoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will action when user clicked
            let newItem = Item()
            newItem.title = TextField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray") //--------------------
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            TextField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}


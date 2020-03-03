//
//  ViewController.swift
//  Checklist
//
//  Created by Mehdi Ghannadan on 1/28/20.
//  Copyright © 2020 Mehdi Ghannadan. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var todoList: TodoList
    
    required init?(coder aDecoder: NSCoder) {

        todoList = TodoList()
        
        super.init(coder: aDecoder)
    }
    
    @IBAction func deleteItems(_ sender: Any) {
        weak var deleteBarButton: UIBarButtonItem!
        if let selectedRows = tableView.indexPathsForSelectedRows {
            var items = [CheckListItem]()
            for indexPath in selectedRows {
                items.append(todoList.todos[indexPath.row])
            }
            todoList.remove(items: items)
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if (editing) {
            super.setEditing(editing, animated: true)
            tableView.setEditing(tableView.isEditing, animated: true)
            self.navigationItem.rightBarButtonItem!.isEnabled = false
        } else {
            super.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem!.isEnabled = true
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = todoList.todos[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            
            self.navigationItem.rightBarButtonItem!.isEnabled = true
            
            return
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = todoList.todos[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)

            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todoList.todos.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todoList.move(item: todoList.todos[sourceIndexPath.row], to: destinationIndexPath.row)
        tableView.reloadData()
    }

    func configureText ( for cell: UITableViewCell, with item: CheckListItem) {
        if let checkmarkCell = cell as? ChecklistTableViewCell {
            checkmarkCell.todoTextLabel.text = item.text
        }
    }
    
    func configureCheckmark ( for cell: UITableViewCell, with item: CheckListItem) {
        guard let checkmarkCell = cell as? ChecklistTableViewCell else {
            return
        }
        let isChecked = item.checked
            if isChecked {
                checkmarkCell.checkmarkLabel.text = "√"
            } else {
                checkmarkCell.checkmarkLabel.text = ""
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemViewController = segue.destination as? ItemDetailViewController { addItemViewController.delegate = self
                addItemViewController.todoList = todoList
            }
        } else if segue.identifier == "EditItemSegue" {
            if let addItemViewController = segue.destination as? ItemDetailViewController {
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) {
                    let item = todoList.todos[indexPath.row]
                    addItemViewController.itemToEdit = item
                    addItemViewController.delegate = self
                }
            }
        }
    }


}

extension ChecklistViewController: itemDetailViewControllerDelegate {
    func itemDetailViewControllerCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: CheckListItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todoList.todos.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: CheckListItem) {
        if let index = todoList.todos.firstIndex(of: item) {
        let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
             configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }

}

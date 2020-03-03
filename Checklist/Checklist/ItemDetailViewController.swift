//
//  itemDetailViewController.swift
//  Checklist
//
//  Created by Mehdi Ghannadan on 2/3/20.
//  Copyright © 2020 Mehdi Ghannadan. All rights reserved.
//

import UIKit

protocol itemDetailViewControllerDelegate: class {
    func itemDetailViewControllerCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: CheckListItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: CheckListItem)
}

class ItemDetailViewController: UITableViewController {
    weak var delegate: itemDetailViewControllerDelegate?
    weak var todoList: TodoList?
    weak var itemToEdit: CheckListItem?
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    

    @IBAction func add(_ sender: Any) {
        if let item = itemToEdit, let text = textField.text {
            item.text = text
            delegate?.itemDetailViewController(self, didFinishEditing: item)
        } else {
            if let item = todoList?.newTodos() {
                if let textFieldText = textField.text {
                    item.text = textFieldText
                }
                item.checked = false
                delegate?.itemDetailViewController(self, didFinishAdding: item)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.itemDetailViewControllerCancel(self)
    }
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            addBarButton.isEnabled = true
        }
        
        navigationItem.largeTitleDisplayMode = .never
    }
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    
}

extension ItemDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text,
        let stringRange = Range(range, in: oldText) else {
            return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            addBarButton.isEnabled = false }
        else {
            addBarButton.isEnabled = true
        }
        return true
    }
    
}

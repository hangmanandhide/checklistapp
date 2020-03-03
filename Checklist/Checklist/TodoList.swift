//
//  TodoList.swift
//  Checklist
//
//  Created by Mehdi Ghannadan on 2/2/20.
//  Copyright © 2020 Mehdi Ghannadan. All rights reserved.
//

import Foundation

class TodoList {
    
    
    var todos: [CheckListItem] = []
    var numberOfInitItems: Int = 5
    
    init() {
        
        var counter = 0
        
        while counter < numberOfInitItems {
            createTodo()
            counter += 1
        }
        
//        let row0Item = CheckListItem()
//        let row1Item = CheckListItem()
//        let row2Item = CheckListItem()
//        let row3Item = CheckListItem()
//        let row4Item = CheckListItem()
//
//        row0Item.text = "Take a jog"
//        row1Item.text = "Watch a movie"
//        row2Item.text = "Code an app"
//        row3Item.text = "Walk the dog"
//        row4Item.text = "Study design patterns"
//
//        todos.append(row0Item)
//        todos.append(row1Item)
//        todos.append(row2Item)
//        todos.append(row3Item)
//        todos.append(row4Item)
    }
//
    func newTodos() -> CheckListItem {
        let item = CheckListItem()
        item.text = randomTitle()
        item.toggleChecked()
        todos.append(item)
        return item
    }
    
    func createTodo() {
        let item = CheckListItem()
        item.text = randomTitle()
        todos.append(item)
    }
    
    func move(item: CheckListItem, to index: Int) {
        guard let currentIndex = todos.firstIndex(of: item) else {
            return
        }
        todos.remove(at: currentIndex)
        todos.insert(item, at: index)
    }
    
    func remove(items: [CheckListItem]) {
        for item in items {
            if let index = todos.firstIndex(of: item) {
                todos.remove(at: index)
            }
        }
    }
    
    private
    
    func randomTitle() -> String {
        let possibleTitles = [
        "A Random Title",
        "A Title Darkly Randomed",
        "Much Title About Nothing",
        "Cant we just be a random title",
        "Rent Here",
        "Take a jog",
        "Watch a movie",
        "Code an app",
        "Walk the dog",
        "Study design patterns"
        ]
        let randomNumber = Int.random(in: 0 ... possibleTitles.count - 1)
        
        return possibleTitles[randomNumber]
        
    }
}

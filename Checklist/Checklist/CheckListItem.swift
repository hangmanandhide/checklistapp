//
//  CheckListItem.swift
//  Checklist
//
//  Created by Mehdi Ghannadan on 2/2/20.
//  Copyright © 2020 Mehdi Ghannadan. All rights reserved.
//

import Foundation

class CheckListItem: NSObject {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
}

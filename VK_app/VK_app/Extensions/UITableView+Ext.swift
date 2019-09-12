//
//  UITableView+Ext.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 09/09/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

extension UITableView {
    func update(deletions: [Int], insertions: [Int], modifications: [Int], section: Int = 0) {
        beginUpdates()
        deleteRows(at: deletions.map { IndexPath(row: $0, section: section) }, with: .automatic)
        insertRows(at: insertions.map { IndexPath(row: $0, section: section) }, with: .automatic)
        reloadRows(at: modifications.map { IndexPath(row: $0, section: section) }, with: .automatic)
        endUpdates()
    }
}
